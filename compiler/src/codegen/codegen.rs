use crate::parser::{ AST, parser::{ BinOp, Block, Expr, Function, Stmt } };
use core::panic;
use std::{ collections::HashMap, fs::File, io::Write };

trait VecExt<T: PartialEq> {
    fn push_unique(&mut self, item: T);
}
impl<T: PartialEq> VecExt<T> for Vec<T> {
    fn push_unique(&mut self, item: T) {
        if !self.contains(&item) {
            self.push(item);
        }
    }
}

#[derive(Debug)]
pub struct CodeGenerator {
    pub file: File,
    pub wh_file: File,
    locals: HashMap<String, i32>,
    dup_pairs: HashMap<String, String>,
    stack_offset: i32,
    label_count: usize,
    hard: bool,
    string_literals: Vec<(String, String)>,
    need_int_print: bool,
    step_counter: i32,
    stmt: i32,
    in_loop: bool,
    next_assignment_location: usize,
    wh_indent: usize,
    metadata: Vec<String>,
    pc: usize,
    metadata_current_registers: Vec<String>,
}

impl CodeGenerator {
    pub fn new(file: File, wh_file: File) -> Self {
        Self {
            file,
            wh_file,
            locals: HashMap::new(),
            dup_pairs: HashMap::new(),
            stack_offset: 0,
            label_count: 0,
            hard: false,
            string_literals: Vec::new(),
            need_int_print: false,
            step_counter: 0,
            in_loop: false,
            next_assignment_location: 6,
            wh_indent: 1,
            metadata: Vec::new(),
            pc: 0,
            stmt: 0,
            metadata_current_registers: Vec::new(),
        }
    }
    pub fn generate(&mut self, ast: AST, is_hard: bool) {
        self.hard = is_hard;
        self.gen_init();
        for func in ast {
            self.emit(func);
        }
        self.emit_print_data();
        self.insert_metadata();

        self.wh_write_line(format!("stmt = (? as ui32);").as_str(), 0);
        self.wh_write_line(format!("bit_shift = (? as ui32);").as_str(), 0);
        self.wh_write_line(format!("assume (bit_shift <= (31 as ui32));").as_str(), 0);
        self.wh_write_line(format!("assume (bit_shift >= (0 as ui32));").as_str(), 0);
        self.wh_write_line(format!("assume (stmt >= (0 as ui32));").as_str(), 0);
        self.wh_write_line(format!("assume (stmt <= ({} as ui32));", self.stmt - 1).as_str(), 0);
        self.wh_write_line(format!("flip_mask = ((1 as ui32) << bit_shift);").as_str(), 0);

        self.wh_write_line("\nres = main(stmt, flip_mask);", 0);
        self.wh_write_line(format!("assert(res == (XYZ as ui32));").as_str(), 0);
    }

    fn gen_init(&mut self) {
        self.write_line(".syntax unified", 0, false);
        self.write_line(".thumb", 0, false);
        self.write_line("", 0, false);
        self.write_line(".section .text", 0, false);
        self.write_line(".global _start", 0, false);
        self.write_line(".type _start, %function", 0, false);
        self.write_line("", 0, false);
    }

    fn write_line(&mut self, string: &str, indents: usize, incr_pc: bool) {
        let indent_str = "    ".repeat(indents);

        // writeln! automatically appends \n
        let _ = writeln!(self.file, "{}{}", indent_str, string);
        if incr_pc {
            self.pc += 1;
        }
    }

    fn wh_write_line(&mut self, string: &str, indents: usize) {
        let indent_str = "    ".repeat(indents);

        // writeln! automatically appends \n
        let _ = writeln!(self.wh_file, "{}{}", indent_str, string);
    }

    fn emit(&mut self, func: Function) {
        match func.name.as_str() {
            "main" => self.emit_main(func),
            _ => self.emit_func(func),
        }
        self.file.sync_all().unwrap();
    }

    fn emit_func(&mut self, _func: Function) {}

    fn emit_main(&mut self, func: Function) {
        self.write_line("_start:", 0, true);
        self.wh_write_line(r#"ui32 res;
ui32 stmt;
ui32 bit_shift;
ui32 flip_mask;
"#, 0);
        self.wh_write_line("fn main(ui32 stmt, ui32 flip_mask) -> ui32 {", 0);
        if self.hard {
            self.write_line("mov r9, #0", 1, true); // step counter in register
            self.write_line("mov r10, #1", 1, true); // step counter in register
            self.wh_write_line("ui32 step_counter;", 1);
            self.wh_write_line("step_counter = (0 as ui32);", 1);
        }
        self.emit_block(func.body, true);
        if self.hard {
            self.emit_countermeasure();
        }
        self.write_line("\n.size _start, .-_start", 0, true);
        self.wh_write_line("}", 0);
    }
    fn emit_block(&mut self, block: Block, is_main: bool) {
        let initial_offset = self.stack_offset;
        let initial_locals = self.locals.clone();
        let initial_dup_pairs = self.dup_pairs.clone();

        let mut has_return = false;
        for stmt in block.statements {
            match stmt {
                Stmt::Let(_, _, _) => self.emit_let(stmt),
                Stmt::AssignStatement(_, _) => self.emit_assign(stmt),
                Stmt::Return(_) => {
                    self.emit_return(stmt, is_main);
                    has_return = true;
                }
                Stmt::If { .. } => self.emit_if(stmt),
                Stmt::While { .. } => self.emit_while(stmt),
                Stmt::Print(exprs) => self.emit_print(exprs),
                _ => panic!("Error found in expression in return"),
            }
            // if self.hard {
            //     self.emit_step_check();
            // }
        }

        let offset_diff = self.stack_offset - initial_offset;
        if offset_diff > 0 && !has_return {
            self.write_line(&format!("add sp, sp, #{}", offset_diff), 1, true);
        }

        self.stack_offset = initial_offset;
        self.locals = initial_locals;
        self.dup_pairs = initial_dup_pairs;
    }
    fn emit_countermeasure(&mut self) {
        self.write_line("countermeasure:", 0, true);

        self.emit_print([Expr::StringLiteral("COUNTERMEASURE".to_string())].into());
        // exit(77)
        self.write_line("mov r0, #77", 1, true);
        self.write_line("mov r7, #1", 1, true);
        self.write_line("svc #0", 1, true);
    }

    fn emit_step_check(&mut self) {
        if !self.hard {
            return;
        }
        self.step_counter += 1;

        if self.in_loop {
            self.write_line("add r9, r9, #1", 1, true);
            self.write_line("cmp r9, r10", 1, true);
            self.write_line("bne countermeasure", 1, true);
            self.write_line("add r10, r10, #1", 1, true);
        } else {
            self.write_line("add r9, r9, #1", 1, true);
            self.write_line(&format!("cmp r9, #{}", self.step_counter), 1, true);
            self.write_line("bne countermeasure", 1, true);

            self.wh_write_line("step_counter++;", self.wh_indent);
            self.wh_write_line(
                &format!("if (step_counter != ({} as ui32)) {{", self.step_counter),
                self.wh_indent
            );
            self.wh_indent += 1;
            self.wh_write_line("return (77 as ui32);", self.wh_indent);
            self.wh_indent -= 1;
            self.wh_write_line("}", self.wh_indent);
        }
    }

    fn emit_print_data(&mut self) {
        if self.string_literals.is_empty() && !self.need_int_print {
            return;
        }
        self.write_line("", 0, false);
        self.write_line(".section .data", 0, false);

        // clone string literals to avoid borrow conflicts while writing
        let literals = self.string_literals.clone();
        for (label, contents) in literals {
            self.write_line(&format!("{}:", label), 0, false);
            self.write_line(&format!(".ascii \"{}\"", contents), 1, false);
        }
        if self.need_int_print {
            self.write_line("newline:", 0, false);
            self.write_line(".ascii \"\\n\"", 1, false);
            self.write_line("num_buf:", 0, false);
            self.write_line(".space 16", 1, false);
        }
        if self.hard {
            self.write_line("step_counter:", 0, false);
            self.write_line(".word 0", 1, false);
            self.write_line("fault_msg:", 0, false);
            self.write_line(".ascii \"Control flow violation detected\\n\"", 1, false);
        }
    }

    fn wh_emit_if_start(&mut self, condition: Expr) {
        self.wh_emit_dup_checks_for_expr(&condition);
        let expr = self.wh_build_expr_str(condition);
        self.wh_write_line(&format!("if ( {expr}) {{"), self.wh_indent);
        self.wh_indent += 1;
    }

    fn emit_if(&mut self, if_stmt: Stmt) {
        match if_stmt {
            Stmt::If { condition, block, option } => {
                let label_id = self.label_count;
                self.label_count += 1;

                self.emit_expr(condition.clone());
                self.wh_emit_if_start(condition);
                self.write_line("cmp r0, #0", 1, true);
                self.write_line(&format!("beq else_{}", label_id), 1, true);

                // save step state
                let saved = self.step_counter;

                // THEN branch
                self.emit_step_check();
                self.emit_block(block, false);

                let saved_then = self.step_counter;

                self.write_line(&format!("b endif_{}", label_id), 1, true);

                // ELSE branch
                self.write_line(&format!("else_{}:", label_id), 0, true);

                self.wh_indent -= 1;
                self.wh_write_line("}", self.wh_indent);

                if let Some(else_block) = option {
                    if self.hard {
                        self.step_counter = saved;
                    }
                    self.wh_write_line("else {", self.wh_indent);
                    self.wh_indent += 1;
                    self.emit_block(else_block, false);
                    if self.hard {
                        self.step_counter = std::cmp::max(self.step_counter, saved_then);
                        self.write_line(&format!("mov r9, #{}", self.step_counter), 1, true);
                        self.wh_write_line(
                            &format!("step_counter = ({} as ui32);", self.step_counter),
                            self.wh_indent
                        );
                    }
                    self.wh_indent -= 1;
                    self.wh_write_line("}", self.wh_indent);
                }

                self.write_line(&format!("endif_{}:", label_id), 0, true);
            }
            _ => panic!("emit_if called with non-if statement"),
        }
    }

    fn emit_while(&mut self, while_stmt: Stmt) {
        match while_stmt {
            Stmt::While { expr, block } => {
                let label_id = self.label_count;
                self.label_count += 1;
                let saved = self.step_counter;
                self.in_loop = true;

                if self.hard {
                    self.write_line(&format!("mov r10, #{}", self.step_counter + 1), 1, true);
                }
                self.write_line(&format!("while_{}:", label_id), 0, true);

                self.emit_step_check();
                self.emit_expr(expr);
                self.write_line("cmp r0, #0", 1, true);
                self.write_line(&format!("beq end_while_{}", label_id), 1, true);

                self.emit_block(block, false);
                self.emit_step_check();

                self.write_line(&format!("b while_{}", label_id), 1, true);
                self.write_line(&format!("end_while_{}:", label_id), 0, true);
                if self.hard {
                    self.step_counter = saved;
                    self.write_line(&format!("mov r9, #{}", self.step_counter), 1, true);
                }
                self.in_loop = false;
            }
            _ => panic!("emit_while called with non-while statement"),
        }
    }
    fn emit_print(&mut self, exprs: Vec<Expr>) {
        if exprs.is_empty() {
            return;
        }

        let last_index = exprs.len().saturating_sub(1);
        for (idx, expr) in exprs.into_iter().enumerate() {
            let is_last = idx == last_index; // newline only after the whole print
            match expr {
                Expr::StringLiteral(raw) => {
                    // Strip surrounding quotes if present
                    let inner = if raw.len() >= 2 && raw.starts_with('"') && raw.ends_with('"') {
                        raw[1..raw.len() - 1].to_string()
                    } else {
                        raw.clone()
                    };

                    let label = format!(".Lstr{}", self.string_literals.len());
                    self.string_literals.push((label.clone(), inner.clone()));

                    // write string to stdout (no newline)
                    self.write_line("mov r0, #1", 1, true);
                    self.write_line(&format!("ldr r1, ={}", label), 1, true);
                    self.write_line(&format!("mov r2, #{}", inner.len()), 1, true);
                    self.write_line("mov r7, #4", 1, true);
                    self.write_line("svc #0", 1, true);
                }
                other => {
                    // Print integer value; newline only after the last argument
                    self.need_int_print = true;
                    self.emit_expr(other);

                    let id = self.label_count;
                    self.label_count += 1;

                    // r0 holds value to print
                    self.write_line("mov r4, r0", 1, true);
                    self.write_line("ldr r1, =num_buf", 1, true);
                    self.write_line("add r1, r1, #16", 1, true);
                    self.write_line("mov r2, #0", 1, true);

                    // handle zero specially
                    self.write_line("cmp r4, #0", 1, true);
                    self.write_line(&format!("bne print_int_loop_{}", id), 1, true);
                    self.write_line("mov r3, #48", 1, true);
                    self.write_line("sub r1, r1, #1", 1, true);
                    self.write_line("strb r3, [r1]", 1, true);
                    self.write_line("mov r2, #1", 1, true);
                    self.write_line(&format!("b print_int_done_{}", id), 1, true);

                    // conversion loop
                    self.write_line(&format!("print_int_loop_{}:", id), 0, true);
                    self.write_line("mov r0, r4", 1, true);
                    self.write_line("mov r3, #10", 1, true);
                    self.write_line("sdiv r5, r0, r3", 1, true); // r5 = value / 10
                    self.write_line("mul r6, r5, r3", 1, true); // r6 = (value/10)*10
                    self.write_line("sub r7, r0, r6", 1, true); // r7 = value % 10
                    self.write_line("add r7, r7, #48", 1, true); // to ASCII
                    self.write_line("sub r1, r1, #1", 1, true);
                    self.write_line("strb r7, [r1]", 1, true);
                    self.write_line("add r2, r2, #1", 1, true);
                    self.write_line("mov r4, r5", 1, true); // value = value / 10
                    self.write_line("cmp r4, #0", 1, true);
                    self.write_line(&format!("bne print_int_loop_{}", id), 1, true);

                    self.write_line(&format!("print_int_done_{}:", id), 0, true);
                    // write digits
                    self.write_line("mov r0, #1", 1, true);
                    self.write_line("mov r1, r1", 1, true);
                    self.write_line("mov r2, r2", 1, true);
                    self.write_line("mov r7, #4", 1, true);
                    self.write_line("svc #0", 1, true);

                    // newline only once, after the last printed value
                    if is_last {
                        self.write_line("mov r0, #1", 1, true);
                        self.write_line("ldr r1, =newline", 1, true);
                        self.write_line("mov r2, #1", 1, true);
                        self.write_line("mov r7, #4", 1, true);
                        self.write_line("svc #0", 1, true);
                    }
                }
            }
        }
    }

    fn wh_emit_return(&mut self, return_str: &str) {
        self.wh_write_line(
            ("return (".to_string() + return_str + " as ui32);").as_str(),
            self.wh_indent
        );
    }

    fn emit_return(&mut self, return_stmt: Stmt, _is_main: bool) {
        match return_stmt {
            Stmt::Return(expr) => {
                self.wh_emit_dup_checks_for_expr(&expr);
                let return_string = self.wh_build_expr_str(expr.clone());
                self.wh_emit_return(&return_string);
                self.emit_expr(expr);
                self.write_line("mov r7, #1", 1, true);
                self.write_line("svc #0", 1, true);
            }
            _ => panic!("return poorly formed"),
        }
    }
    fn emit_assign(&mut self, assign_stmt: Stmt) {
        match assign_stmt.clone() {
            Stmt::AssignStatement(name, expr) => {
                self.metadata_current_registers.clear();
                self.metadata_current_registers.push_unique("r0".to_string());
                let curr_stmt = self.stmt;
                let pc_before = self.pc;
                let rhs_is_id = matches!(&expr, Expr::Identifier(_));
                self.emit_expr(expr);
                let offset = self.locals.get(&name).expect("Undefined variable");
                if self.stack_offset - offset == 0 {
                    self.write_line("str r0, [sp]", 1, true);
                } else {
                    self.write_line(
                        &format!("str r0, [sp, #{}]", self.stack_offset - offset),
                        1,
                        true
                    );
                }
                if self.hard && self.dup_pairs.contains_key(&name) {
                    let dup_name = self.dup_pairs.get(&name).unwrap();
                    let dup_offset = self.locals.get(dup_name).expect("Undefined dup variable");
                    let dup_store = if self.stack_offset - dup_offset == 0 {
                        "str r0, [sp]".to_string()
                    } else {
                        format!("str r0, [sp, #{}]", self.stack_offset - dup_offset)
                    };
                    if rhs_is_id {
                        self.write_line("mov r0, r2", 1, true);
                    }
                    self.write_line(&dup_store, 1, true);
                }
                self.wh_emit_assign(assign_stmt);
                if self.hard {
                    self.emit_step_check();
                }
                let pc_after = self.pc - 1;

                self.metadata.push(format!(r#".word 0x10000000 @ {curr_stmt}"#));
                self.metadata.push(format!(r#".word 0xa+{pc_before}"#));
                self.metadata.push(format!(r#".word 0xb+{pc_after}"#));
                let register_string = format!("[{}]", self.metadata_current_registers.join(","));
                self.metadata.push(format!(r#".word 0x0 @ {register_string}"#));
                self.metadata_current_registers.clear();
                self.metadata.push(format!(r#".word 0x00000001 @ {name}"#));
                if self.hard && self.dup_pairs.contains_key(&name) {
                    let dup_name = self.dup_pairs.get(&name).unwrap();
                    self.metadata.push(format!(r#".word 0x00000001 @ {dup_name}"#));
                }
            }
            _ => panic!("Not a valid assignment"),
        }
    }
    fn wh_emit_assign(&mut self, assign_stmt: Stmt) {
        match assign_stmt {
            Stmt::AssignStatement(identifyer, expr) => {
                self.wh_emit_dup_checks_for_expr(&expr);
                let expr_str = self.wh_build_expr_str(expr.clone());
                if expr_str == "".to_string() {
                    return;
                }
                let assign_line = format!("{identifyer} = {expr_str}");
                self.wh_write_line(&format!("{assign_line};"), self.wh_indent);

                if self.hard && self.dup_pairs.contains_key(&identifyer) {
                    let dup_name = self.dup_pairs.get(&identifyer).unwrap();
                    let dup_val = self.wh_build_dup_expr_str(expr);
                    let assign_dup_line = format!("{dup_name} = {dup_val}");
                    self.wh_write_line(&format!("{assign_dup_line};"), self.wh_indent);
                }

                self.wh_instrument_assign(assign_line.as_str());
            }
            _ => panic!("Not an assign stmt (wh)"),
        }
    }
    fn insert_metadata(&mut self) {
        self.write_line("_metadata:", 0, true);
        for met in self.metadata.clone() {
            self.write_line(met.as_str(), 1, true);
        }
    }
    fn insert_at_line(&mut self, line_num: usize, new_content: &str) -> std::io::Result<()> {
        use std::io::{ Read, Write, Seek, SeekFrom };

        // 1. Read existing content
        let mut content = String::new();
        self.wh_file.seek(SeekFrom::Start(0))?;
        self.wh_file.read_to_string(&mut content)?;

        // 2. Split into lines
        // Note: lines() omits the trailing newline; we'll add it back during join
        let mut lines: Vec<String> = content
            .lines()
            .map(|s| s.to_string())
            .collect();

        // 3. Insert the line
        // If line_num is 2 (1-based), user likely means index 1
        // Adjust logic here if you want 0-based or 1-based indexing
        if line_num <= lines.len() {
            lines.insert(line_num, new_content.to_string());
        } else {
            // If line_num is beyond the end, just push it
            lines.push(new_content.to_string());
        }

        // 4. Overwrite the file
        self.wh_file.set_len(0)?;
        self.wh_file.seek(SeekFrom::Start(0))?;
        self.wh_file.write_all(lines.join("\n").as_bytes())?;

        // Add a final newline if you want the file to end with one
        self.wh_file.write_all(b"\n")?;

        Ok(())
    }

    fn emit_let(&mut self, let_stmt: Stmt) {
        let curr_stmt = self.stmt;
        self.wh_emit_let(let_stmt.clone());
        match let_stmt {
            Stmt::Let(name, _type_name, expr) => {
                let dup_name = format!("{}_dup", name);
                self.metadata_current_registers.clear();
                self.metadata_current_registers.push("r0".to_string());
                self.stack_offset += 4;
                let pc_before = self.pc;
                self.write_line("sub sp, sp, #4", 1, true);
                self.emit_expr(expr.clone());
                self.write_line("str r0, [sp]", 1, true);
                self.locals.insert(name.clone(), self.stack_offset);

                if self.hard {
                    self.stack_offset += 4;
                    self.write_line("sub sp, sp, #4", 1, true);
                    match &expr {
                        Expr::Identifier(rhs_name) if self.dup_pairs.contains_key(rhs_name) => {
                            self.write_line("mov r0, r2", 1, true);
                        }
                        _ => {
                            self.emit_expr(expr.clone());
                        }
                    }
                    self.write_line("str r0, [sp]", 1, true);
                    self.locals.insert(dup_name.clone(), self.stack_offset);
                    self.dup_pairs.insert(name.clone(), dup_name.clone());
                    self.dup_pairs.insert(dup_name.clone(), name.clone());
                    self.emit_step_check();
                }

                let pc_after = self.pc - 1;

                self.metadata.push(format!(r#".word 0x10000000 @ {curr_stmt}"#));
                self.metadata.push(format!(r#".word 0xa+{pc_before}"#));
                self.metadata.push(format!(r#".word 0xb+{pc_after}"#));
                let register_string = format!("[{}]", self.metadata_current_registers.join(","));
                self.metadata.push(format!(r#".word 0x0 @ {register_string}"#));
                self.metadata_current_registers.clear();
                self.metadata.push(format!(r#".word 0x00000001 @ {name}"#));
                if self.hard {
                    self.metadata.push(format!(r#".word 0x00000002 @ {dup_name}"#));
                }
            }
            _ => panic!("Not a let statement format sorry "),
        }
    }
    fn wh_emit_let(&mut self, let_stmt: Stmt) {
        match let_stmt {
            Stmt::Let(name, _type_name, expr) => {
                let indent_str = "    ".repeat(1);
                let combined = indent_str.clone() + "ui32 " + name.as_str() + ";";
                self.insert_at_line(self.next_assignment_location, combined.as_str());
                self.next_assignment_location += 1;

                if self.hard {
                    let dup_name = format!("{}_dup", name);
                    let combined_dup = indent_str.clone() + "ui32 " + dup_name.as_str() + ";";
                    self.insert_at_line(self.next_assignment_location, combined_dup.as_str());
                    self.next_assignment_location += 1;
                    self.dup_pairs.insert(name.clone(), dup_name.clone());
                    self.dup_pairs.insert(dup_name, name.clone());
                }

                let val = self.wh_build_expr_str(expr.clone());
                let assign_line = name.clone() + " = " + val.as_str();

                self.wh_write_line(format!("{};", assign_line.as_str()).as_str(), self.wh_indent);

                if self.hard {
                    let dup_name = format!("{}_dup", name);
                    let dup_val = self.wh_build_dup_expr_str(expr);
                    let assign_dup_line = dup_name + " = " + dup_val.as_str();
                    self.wh_write_line(
                        format!("{};", assign_dup_line.as_str()).as_str(),
                        self.wh_indent
                    );
                }

                self.wh_instrument_assign(assign_line.as_str());
            }
            _ => panic!("Not a let statement format sorry (wh emit)"),
        }
    }
    fn wh_instrument_assign(&mut self, assign_line: &str) {
        self.wh_write_line(
            format!("if (stmt == ({} as ui32)) {{", self.stmt).as_str(),
            self.wh_indent
        );
        self.wh_indent += 1;
        self.wh_write_line(format!("{} ^ flip_mask;", assign_line).as_str(), self.wh_indent);
        self.wh_indent -= 1;
        self.wh_write_line("}", self.wh_indent);
        self.stmt += 1;
    }
    fn wh_emit_dup_check(&mut self, name: &str) {
        if self.hard && self.dup_pairs.contains_key(name) {
            let dup_name = self.dup_pairs.get(name).unwrap().clone();
            self.wh_write_line(&format!("if ({name} != {dup_name}) {{"), self.wh_indent);
            self.wh_indent += 1;
            self.wh_write_line("return (77 as ui32);", self.wh_indent);
            self.wh_indent -= 1;
            self.wh_write_line("}", self.wh_indent);
        }
    }
    fn wh_emit_dup_checks_for_expr(&mut self, expr: &Expr) {
        match expr {
            Expr::Identifier(name) => {
                self.wh_emit_dup_check(name);
            }
            Expr::BinaryOp(left, _, right) => {
                self.wh_emit_dup_checks_for_expr(left);
                self.wh_emit_dup_checks_for_expr(right);
            }
            Expr::UnaryOp(_, inner) => {
                self.wh_emit_dup_checks_for_expr(inner);
            }
            _ => {}
        }
    }
    fn wh_build_expr_str(&self, expr: Expr) -> String {
        self.wh_build_expr_str_impl(expr, false)
    }

    fn wh_build_dup_expr_str(&self, expr: Expr) -> String {
        self.wh_build_expr_str_impl(expr, true)
    }

    fn wh_build_expr_str_impl(&self, expr: Expr, use_dup: bool) -> String {
        match expr {
            Expr::IntegerLiteral(val) => format!("({val} as ui32)"),
            Expr::BooleanLiteral(val) => {
                let ival = if val { 1 } else { 0 };
                format!("{ival}")
            }
            Expr::StringLiteral(_val) => "".to_string(),
            Expr::Identifier(val) => {
                if use_dup && self.hard && self.dup_pairs.contains_key(&val) {
                    self.dup_pairs.get(&val).unwrap().clone()
                } else {
                    val
                }
            }
            Expr::BinaryOp(left, op, right) => {
                let left_str = self.wh_build_expr_str_impl(*left, use_dup);
                let right_str = self.wh_build_expr_str_impl(*right, use_dup);
                let op_str = match op {
                    BinOp::Add => "+",
                    BinOp::Sub => "-",
                    BinOp::Mul => "*",
                    BinOp::Div => "/",
                    BinOp::LessThan => "<",
                    BinOp::GreaterThan => ">",
                    BinOp::Equals => "==",
                    BinOp::NotEquals => "!=",
                };
                format!("{left_str} {op_str} {right_str}")
            }
            Expr::UnaryOp(_, _) => "".to_string(),
            _ => panic!("building expr string went wrong"),
        }
    }

    fn emit_expr(&mut self, expr: Expr) {
        match expr {
            Expr::IntegerLiteral(val) => self.write_line(&format!("mov r0, #{}", val), 1, true),
            Expr::BooleanLiteral(val) => {
                if val {
                    self.write_line(&format!("mov r0, #{}", 1), 1, true)
                } else {
                    self.write_line(&format!("mov r0, #{}", 0), 1, true)
                }
            }
            Expr::Identifier(name) => {
                let offset = self.locals.get(&name).expect("Undefined variable");
                self.write_line(&format!("ldr r0, [sp, #{}]", self.stack_offset - offset), 1, true);
                if self.hard && self.dup_pairs.contains_key(&name) {
                    let dup_name = self.dup_pairs.get(&name).unwrap();
                    let dup_offset = self.locals.get(dup_name).expect("Undefined dup variable");
                    self.write_line(
                        &format!("ldr r2, [sp, #{}]", self.stack_offset - dup_offset),
                        1,
                        true
                    );
                    self.write_line("cmp r0, r2", 1, true);
                    self.write_line("bne countermeasure", 1, true);
                }
            }
            Expr::BinaryOp(_, _, _) => {
                self.emit_bin_op(expr);
            }

            _ => panic!("Expression not valid sorry"),
        }
    }
    fn emit_bin_op(&mut self, bin_op_expr: Expr) {
        match bin_op_expr {
            Expr::BinaryOp(left, op, right) => {
                self.emit_expr(*left);
                self.write_line("sub sp, sp, #4", 1, true);
                self.stack_offset += 4;
                self.write_line("str r0, [sp, #0]", 1, true);
                self.emit_expr(*right);
                self.write_line("ldr r1, [sp, #0]", 1, true);
                self.write_line("add sp, sp, #4", 1, true);
                self.stack_offset -= 4;

                match op {
                    BinOp::Add => self.write_line("add r0, r1, r0", 1, true),
                    BinOp::Sub => self.write_line("sub r0, r1, r0", 1, true),
                    BinOp::Mul => self.write_line("mul r0, r1, r0", 1, true),
                    BinOp::Div => self.write_line("sdiv r0, r1, r0", 1, true),

                    BinOp::Equals => {
                        self.write_line("cmp r1, r0", 1, true);
                        self.write_line("mov r0, #0", 1, true);
                        self.write_line("it eq", 1, true);
                        self.write_line("moveq r0, #1", 1, true);
                    }

                    BinOp::NotEquals => {
                        self.write_line("cmp r1, r0", 1, true);
                        self.write_line("mov r0, #0", 1, true);
                        self.write_line("it ne", 1, true);
                        self.write_line("movne r0, #1", 1, true);
                    }

                    BinOp::GreaterThan => {
                        self.write_line("cmp r1, r0", 1, true);
                        self.write_line("mov r0, #0", 1, true);
                        self.write_line("it gt", 1, true);
                        self.write_line("movgt r0, #1", 1, true);
                    }

                    BinOp::LessThan => {
                        self.write_line("cmp r1, r0", 1, true);
                        self.write_line("mov r0, #0", 1, true);
                        self.write_line("it lt", 1, true);
                        self.write_line("movlt r0, #1", 1, true);
                    }
                }
            }
            _ => panic!("not a binary operation if ive ever seen one"),
        }
    }
}

#[cfg(test)]
mod tests {
    use crate::lexer::{ lexer::Lexer, token::Token };
    use crate::parser::parser::{ Parser, AST };
    use crate::CodeGenerator;
    use std::fs::File;
    use std::io::{ Read, Seek, SeekFrom };
    use std::sync::Once;

    static INIT: Once = Once::new();

    fn initialize() {
        INIT.call_once(|| {
            let mut path = std::path::PathBuf::from(std::env::var("CARGO_MANIFEST_DIR").unwrap());
            path.push("temp/tests");
            std::fs::create_dir_all(path).unwrap();
        });
    }

    #[test]
    fn can_generate_init() {
        initialize();
        let output_file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .truncate(true)
            .open("temp/tests/test_can_generate_init.s")
            .expect("Failed to create file: /temp/tests/test_can_generate_init.s");
        let wh_output_file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .truncate(true)
            .open("temp/tests/test_can_generate_init.wh")
            .expect("Failed to create file: /temp/tests/test_can_generate_init.wh");
        let ast = AST::new();
        let mut codegen = CodeGenerator::new(output_file, wh_output_file);
        codegen.generate(ast, false);
        codegen.file.seek(SeekFrom::Start(0)).unwrap();
        let mut buf = String::new();
        codegen.file.read_to_string(&mut buf).unwrap();
        let expected = (
            indoc::indoc! {
                r##"
            .syntax unified
            .thumb

            .section .text
            .global _start
            .type _start, %function

            _metadata:
            "##
            }
        ).to_string();
        assert_eq!(expected, buf);
    }

    #[test]
    fn can_generate_return() {
        initialize();
        let source = std::fs
            ::read_to_string("test_codes/test_main_return.trv")
            .expect("Failed to read file");
        let mut lexer: Lexer = Lexer::new(source);
        let tokens: Vec<Token> = lexer.tokenize();
        let mut parser: Parser = Parser::new(tokens);
        let ast: AST = parser.parse_program();
        let output_file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .truncate(true)
            .open("temp/tests/test_can_generate_return.s")
            .expect("Failed to create file: /temp/tests/test_can_generate_return.s");
        let wh_output_file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .truncate(true)
            .open("temp/tests/test_can_generate_return.wh")
            .expect("Failed to create file: /temp/tests/test_can_generate_return.wh");
        let mut codegen = CodeGenerator::new(output_file, wh_output_file);
        codegen.generate(ast, false);
        codegen.file.seek(SeekFrom::Start(0)).unwrap();
        let mut buf = String::new();
        codegen.file.read_to_string(&mut buf).unwrap();
        let expected = (
            indoc::indoc! {
                r##"
                .syntax unified
                .thumb

                .section .text
                .global _start
                .type _start, %function

                _start:
                    mov r0, #69
                    mov r7, #1
                    svc #0

                .size _start, .-_start
                _metadata:
            "##
            }
        ).to_string();
        assert_eq!(expected, buf)
    }

    #[test]
    fn can_generate_let() {
        initialize();
        let source = std::fs
            ::read_to_string("test_codes/test_main_let.trv")
            .expect("Failed to read file");
        let mut lexer: Lexer = Lexer::new(source);
        let tokens: Vec<Token> = lexer.tokenize();
        let mut parser: Parser = Parser::new(tokens);
        let ast: AST = parser.parse_program();
        let output_file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .truncate(true)
            .open("temp/tests/test_can_generate_let.s")
            .expect("Failed to create file: /temp/tests/test_can_generate_let.s");
        let wh_output_file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .truncate(true)
            .open("temp/tests/test_can_generate_let.wh")
            .expect("Failed to create file: /temp/tests/test_can_generate_let.wh");
        let mut codegen = CodeGenerator::new(output_file, wh_output_file);
        codegen.generate(ast, false);
        codegen.file.seek(SeekFrom::Start(0)).unwrap();
        let mut buf = String::new();
        codegen.file.read_to_string(&mut buf).unwrap();
        let expected = (
            indoc::indoc! {
                r##"
                .syntax unified
                .thumb

                .section .text
                .global _start
                .type _start, %function

                _start:
                    sub sp, sp, #4
                    mov r0, #27
                    str r0, [sp]
                    ldr r0, [sp, #0]
                    mov r7, #1
                    svc #0

                .size _start, .-_start
                _metadata:
                    .word 0x10000000 @ 0
                    .word 0xa+1
                    .word 0xb+3
                    .word 0x0 @ [r0]
                    .word 0x00000001 @ num
            "##
            }
        ).to_string();
        assert_eq!(expected, buf)
    }
    #[test]
    fn can_generate_if_else_and_assign() {
        initialize();
        let source = std::fs
            ::read_to_string("test_codes/test_if_else.trv")
            .expect("Failed to read file");
        let mut lexer: Lexer = Lexer::new(source);
        let tokens: Vec<Token> = lexer.tokenize();
        let mut parser: Parser = Parser::new(tokens);
        let ast: AST = parser.parse_program();
        let output_file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .truncate(true)
            .open("temp/tests/test_can_generate_if_else.s")
            .expect("Failed to create file: /temp/tests/test_can_generate_if_else.s");
        let wh_output_file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .truncate(true)
            .open("temp/tests/test_can_generate_if_else.wh")
            .expect("Failed to create file: /temp/tests/test_can_generate_if_else.wh");
        let mut codegen = CodeGenerator::new(output_file, wh_output_file);
        codegen.generate(ast, false);
        codegen.file.seek(SeekFrom::Start(0)).unwrap();
        let mut buf = String::new();
        codegen.file.read_to_string(&mut buf).unwrap();
        let expected = (
            indoc::indoc! {
                r##"
                .syntax unified
                .thumb

                .section .text
                .global _start
                .type _start, %function

                _start:
                    sub sp, sp, #4
                    mov r0, #9
                    str r0, [sp]
                    ldr r0, [sp, #0]
                    mov r1, r0
                    mov r0, #10
                    cmp r1, r0
                    mov r0, #0
                    it gt
                    movgt r0, #1
                    cmp r0, #0
                    beq else_0
                    mov r0, #11
                    str r0, [sp]
                    b endif_0
                else_0:
                    mov r0, #12
                    str r0, [sp]
                endif_0:
                    ldr r0, [sp, #0]
                    mov r7, #1
                    svc #0

                .size _start, .-_start
                _metadata:
                    .word 0x10000000 @ 0
                    .word 0xa+1
                    .word 0xb+3
                    .word 0x0 @ [r0]
                    .word 0x00000001 @ num
                    .word 0x10000000 @ 1
                    .word 0xa+13
                    .word 0xb+14
                    .word 0x0 @ [r0]
                    .word 0x00000001 @ num
                    .word 0x10000000 @ 2
                    .word 0xa+17
                    .word 0xb+18
                    .word 0x0 @ [r0]
                    .word 0x00000001 @ num
                "##
            }
        ).to_string();
        assert_eq!(expected, buf)
    }

    #[test]
    fn can_generate_while() {
        initialize();
        let source = std::fs
            ::read_to_string("test_codes/test_while_simple.trv")
            .expect("Failed to read file");
        let mut lexer: Lexer = Lexer::new(source);
        let tokens: Vec<Token> = lexer.tokenize();
        let mut parser: Parser = Parser::new(tokens);
        let ast: AST = parser.parse_program();
        let output_file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .truncate(true)
            .open("temp/tests/test_can_generate_while.s")
            .expect("Failed to create file: /temp/tests/test_can_generate_while.s");
        let wh_output_file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .truncate(true)
            .open("temp/tests/test_can_generate_while.wh")
            .expect("Failed to create file: /temp/tests/test_can_generate_while.wh");
        let mut codegen = CodeGenerator::new(output_file, wh_output_file);
        codegen.generate(ast, false);
        codegen.file.seek(SeekFrom::Start(0)).unwrap();
        let mut buf = String::new();
        codegen.file.read_to_string(&mut buf).unwrap();
        let expected = (
            indoc::indoc! {
                r##"
            .syntax unified
            .thumb

            .section .text
            .global _start
            .type _start, %function

            _start:
                sub sp, sp, #4
                mov r0, #9
                str r0, [sp]
            while_0:
                ldr r0, [sp, #0]
                mov r1, r0
                mov r0, #12
                cmp r1, r0
                mov r0, #0
                it lt
                movlt r0, #1
                cmp r0, #0
                beq end_while_0
                ldr r0, [sp, #0]
                mov r1, r0
                mov r0, #1
                add r0, r1, r0
                str r0, [sp]
                b while_0
            end_while_0:
                ldr r0, [sp, #0]
                mov r7, #1
                svc #0

            .size _start, .-_start
            _metadata:
                .word 0x10000000 @ 0
                .word 0xa+1
                .word 0xb+3
                .word 0x0 @ [r0]
                .word 0x00000001 @ num
                .word 0x10000000 @ 1
                .word 0xa+14
                .word 0xb+18
                .word 0x0 @ [r0,r1]
                .word 0x00000001 @ num
            "##
            }
        ).to_string();
        assert_eq!(expected, buf)
    }

    #[test]
    fn can_generate_two_whiles() {
        initialize();
        let source = std::fs
            ::read_to_string("test_codes/test_while_two_loops.trv")
            .expect("Failed to read file");
        let mut lexer: Lexer = Lexer::new(source);
        let tokens: Vec<Token> = lexer.tokenize();
        let mut parser: Parser = Parser::new(tokens);
        let ast: AST = parser.parse_program();
        let output_file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .truncate(true)
            .open("temp/tests/test_can_generate_two_whiles.s")
            .expect("Failed to create file: /temp/tests/test_can_generate_two_whiles.s");
        let wh_output_file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .truncate(true)
            .open("temp/tests/test_can_generate_two_whiles.wh")
            .expect("Failed to create file: /temp/tests/test_can_generate_two_whiles.wh");
        let mut codegen = CodeGenerator::new(output_file, wh_output_file);
        codegen.generate(ast, false);
        codegen.file.seek(SeekFrom::Start(0)).unwrap();
        let mut buf = String::new();
        codegen.file.read_to_string(&mut buf).unwrap();
        let expected = (
            indoc::indoc! {
                r##"
                .syntax unified
                .thumb

                .section .text
                .global _start
                .type _start, %function

                _start:
                    sub sp, sp, #4
                    mov r0, #0
                    str r0, [sp]
                    sub sp, sp, #4
                    mov r0, #0
                    str r0, [sp]
                while_0:
                    ldr r0, [sp, #4]
                    mov r1, r0
                    mov r0, #3
                    cmp r1, r0
                    mov r0, #0
                    it lt
                    movlt r0, #1
                    cmp r0, #0
                    beq end_while_0
                    ldr r0, [sp, #4]
                    mov r1, r0
                    mov r0, #1
                    add r0, r1, r0
                    str r0, [sp, #4]
                    b while_0
                end_while_0:
                while_1:
                    ldr r0, [sp, #0]
                    mov r1, r0
                    mov r0, #4
                    cmp r1, r0
                    mov r0, #0
                    it lt
                    movlt r0, #1
                    cmp r0, #0
                    beq end_while_1
                    ldr r0, [sp, #0]
                    mov r1, r0
                    mov r0, #1
                    add r0, r1, r0
                    str r0, [sp]
                    b while_1
                end_while_1:
                    ldr r0, [sp, #4]
                    mov r1, r0
                    ldr r0, [sp, #0]
                    add r0, r1, r0
                    mov r7, #1
                    svc #0

                .size _start, .-_start
                _metadata:
                    .word 0x10000000 @ 0
                    .word 0xa+1
                    .word 0xb+3
                    .word 0x0 @ [r0]
                    .word 0x00000001 @ a
                    .word 0x10000000 @ 1
                    .word 0xa+4
                    .word 0xb+6
                    .word 0x0 @ [r0]
                    .word 0x00000001 @ b
                    .word 0x10000000 @ 2
                    .word 0xa+17
                    .word 0xb+21
                    .word 0x0 @ [r0,r1]
                    .word 0x00000001 @ a
                    .word 0x10000000 @ 3
                    .word 0xa+34
                    .word 0xb+38
                    .word 0x0 @ [r0,r1]
                    .word 0x00000001 @ b
                "##
            }
        ).to_string();
        assert_eq!(expected, buf)
    }

    #[test]
    fn can_generate_nested_while() {
        initialize();
        let source = std::fs
            ::read_to_string("test_codes/test_while_nested.trv")
            .expect("Failed to read file");
        let mut lexer: Lexer = Lexer::new(source);
        let tokens: Vec<Token> = lexer.tokenize();
        let mut parser: Parser = Parser::new(tokens);
        let ast: AST = parser.parse_program();
        let output_file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .truncate(true)
            .open("temp/tests/test_can_generate_nested_while.s")
            .expect("Failed to create file: /temp/tests/test_can_generate_nested_while.s");
        let wh_output_file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .truncate(true)
            .open("temp/tests/test_can_generate_nested_while.wh")
            .expect("Failed to create file: /temp/tests/test_can_generate_nested_while.wh");
        let mut codegen = CodeGenerator::new(output_file, wh_output_file);
        codegen.generate(ast, false);
        codegen.file.seek(SeekFrom::Start(0)).unwrap();
        let mut buf = String::new();
        codegen.file.read_to_string(&mut buf).unwrap();
        let expected = (
            indoc::indoc! {
                r##"
                .syntax unified
                .thumb

                .section .text
                .global _start
                .type _start, %function

                _start:
                    sub sp, sp, #4
                    mov r0, #0
                    str r0, [sp]
                while_0:
                    ldr r0, [sp, #0]
                    mov r1, r0
                    mov r0, #3
                    cmp r1, r0
                    mov r0, #0
                    it lt
                    movlt r0, #1
                    cmp r0, #0
                    beq end_while_0
                    sub sp, sp, #4
                    mov r0, #0
                    str r0, [sp]
                while_1:
                    ldr r0, [sp, #0]
                    mov r1, r0
                    mov r0, #2
                    cmp r1, r0
                    mov r0, #0
                    it lt
                    movlt r0, #1
                    cmp r0, #0
                    beq end_while_1
                    ldr r0, [sp, #0]
                    mov r1, r0
                    mov r0, #1
                    add r0, r1, r0
                    str r0, [sp]
                    b while_1
                end_while_1:
                    ldr r0, [sp, #4]
                    mov r1, r0
                    mov r0, #1
                    add r0, r1, r0
                    str r0, [sp, #4]
                    add sp, sp, #4
                    b while_0
                end_while_0:
                    ldr r0, [sp, #0]
                    mov r7, #1
                    svc #0

                .size _start, .-_start
                _metadata:
                    .word 0x10000000 @ 0
                    .word 0xa+1
                    .word 0xb+3
                    .word 0x0 @ [r0]
                    .word 0x00000001 @ a
                    .word 0x10000000 @ 1
                    .word 0xa+14
                    .word 0xb+16
                    .word 0x0 @ [r0]
                    .word 0x00000001 @ b
                    .word 0x10000000 @ 2
                    .word 0xa+27
                    .word 0xb+31
                    .word 0x0 @ [r0,r1]
                    .word 0x00000001 @ b
                    .word 0x10000000 @ 3
                    .word 0xa+34
                    .word 0xb+38
                    .word 0x0 @ [r0,r1]
                    .word 0x00000001 @ a
            "##
            }
        ).to_string();
        assert_eq!(expected, buf)
    }

    #[test]
    fn compiles_all_correct() {
        initialize();

        let test_codes_dir = std::path::Path::new("test_codes");
        let trv_files: Vec<_> = std::fs
            ::read_dir(test_codes_dir)
            .unwrap()
            .filter_map(|entry| {
                let path = entry.unwrap().path();
                if path.extension().map_or(false, |ext| ext == "trv") {
                    Some(path)
                } else {
                    None
                }
            })
            .collect();

        for trv_path in trv_files {
            let source = std::fs::read_to_string(&trv_path).expect("Failed to read trv file");
            let mut lexer: Lexer = Lexer::new(source);
            let tokens: Vec<Token> = lexer.tokenize();
            let mut parser: Parser = Parser::new(tokens);
            let ast: AST = parser.parse_program();

            let file_stem = trv_path.file_stem().unwrap().to_str().unwrap();
            let output_asm_path = format!("temp/tests/{}.s", file_stem);
            let output_wh_path = format!("temp/tests/{}.wh", file_stem);
            let output_file = File::options()
                .read(true)
                .write(true)
                .create(true)
                .truncate(true)
                .open(&output_asm_path)
                .expect(&format!("Failed to create file: {}", output_asm_path));

            let wh_output_file = File::options()
                .read(true)
                .write(true)
                .create(true)
                .truncate(true)
                .open(&output_wh_path)
                .expect(&format!("Failed to create file: {}", output_wh_path));
            let mut codegen = CodeGenerator::new(output_file, wh_output_file);
            codegen.generate(ast, false);

            let output_path = trv_path.with_extension("trv.output");
            let expected_exit_code = std::fs
                ::read_to_string(&output_path)
                .expect("Failed to read output file")
                .trim()
                .parse::<i32>()
                .expect("Failed to parse exit code");

            let result = std::process::Command::new("./bin/run_asm").arg(&output_asm_path).output();
            let mut actual_exit_code: i32 = 0;
            if trv_path.to_str().unwrap().contains("hash") {
                actual_exit_code = match result {
                    Ok(output) => {
                        let stdout_text = String::from_utf8_lossy(&output.stdout);

                        let lines: Vec<&str> = stdout_text.lines().collect();
                        let value = lines[1].parse::<i32>().ok();
                        value.unwrap()
                    }
                    Err(e) => panic!("{}", e),
                };
            } else {
                actual_exit_code = match result {
                    Ok(output) => output.status.code().unwrap_or(-1),
                    Err(e) => panic!("{}", e),
                };
            }

            std::fs::remove_file(&output_asm_path).ok();

            assert_eq!(
                expected_exit_code,
                actual_exit_code,
                "File {}: expected exit code {}, got {}",
                file_stem,
                expected_exit_code,
                actual_exit_code
            );
        }
    }
    #[test]
    fn compiles_all_hard_correct() {
        initialize();

        let test_codes_dir = std::path::Path::new("test_codes");
        let trv_files: Vec<_> = std::fs
            ::read_dir(test_codes_dir)
            .unwrap()
            .filter_map(|entry| {
                let path = entry.unwrap().path();
                if path.extension().map_or(false, |ext| ext == "trv") {
                    Some(path)
                } else {
                    None
                }
            })
            .collect();

        for trv_path in trv_files {
            let source = std::fs::read_to_string(&trv_path).expect("Failed to read trv file");
            let mut lexer: Lexer = Lexer::new(source);
            let tokens: Vec<Token> = lexer.tokenize();
            let mut parser: Parser = Parser::new(tokens);
            let ast: AST = parser.parse_program();

            let file_stem = trv_path.file_stem().unwrap().to_str().unwrap();
            let output_asm_path = format!("temp/tests/{}.s", file_stem);
            let output_wh_path = format!("temp/tests/{}.wh", file_stem);
            let output_file = File::options()
                .read(true)
                .write(true)
                .create(true)
                .truncate(true)
                .open(&output_asm_path)
                .expect(&format!("Failed to create file: {}", output_asm_path));

            let wh_output_file = File::options()
                .read(true)
                .write(true)
                .create(true)
                .truncate(true)
                .open(&output_wh_path)
                .expect(&format!("Failed to create file: {}", output_wh_path));
            let mut codegen = CodeGenerator::new(output_file, wh_output_file);
            codegen.generate(ast, true);

            let output_path = trv_path.with_extension("trv.output");
            let expected_exit_code = std::fs
                ::read_to_string(&output_path)
                .expect("Failed to read output file")
                .trim()
                .parse::<i32>()
                .expect("Failed to parse exit code");

            let result = std::process::Command::new("./bin/run_asm").arg(&output_asm_path).output();
            let mut actual_exit_code: i32 = 0;
            if trv_path.to_str().unwrap().contains("hash") {
                actual_exit_code = match result {
                    Ok(output) => {
                        let stdout_text = String::from_utf8_lossy(&output.stdout);

                        let lines: Vec<&str> = stdout_text.lines().collect();
                        let value = lines[1].parse::<i32>().ok();
                        value.unwrap()
                    }
                    Err(e) => panic!("{}", e),
                };
            } else {
                actual_exit_code = match result {
                    Ok(output) => output.status.code().unwrap_or(-1),
                    Err(e) => panic!("{}", e),
                };
            }

            std::fs::remove_file(&output_asm_path).ok();

            assert_eq!(
                expected_exit_code,
                actual_exit_code,
                "File {}: expected exit code {}, got {}",
                file_stem,
                expected_exit_code,
                actual_exit_code
            );
            
        }
    }
}
