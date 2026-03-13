use crate::parser::{ parser::{ BinOp, Block, Expr, Function, Stmt }, AST };
use core::panic;
use std::{ collections::HashMap, fs::File, io::Write };

#[derive(Debug)]
pub struct CodeGenerator {
    pub file: File,
    locals: HashMap<String, i32>,
    stack_offset: i32,
    label_count: usize,
    hard: bool,
    string_literals: Vec<(String, String)>,
    need_int_print: bool,
    step_counter: i32,
}

impl CodeGenerator {
    pub fn new(file: File) -> Self {
        Self {
            file,
            locals: HashMap::new(),
            stack_offset: 0,
            label_count: 0,
            hard: false,
            string_literals: Vec::new(),
            need_int_print: false,
            step_counter: 0,
        }
    }
    pub fn generate(&mut self, ast: AST, is_hard: bool) {
        self.hard = is_hard;
        self.gen_init();
        for func in ast {
            self.emit(func);
        }
        if self.hard {
            self.emit_countermeasure();
        }
        self.emit_print_data();
    }

    fn gen_init(&mut self) {
        self.write_line(".syntax unified", 0);
        self.write_line(".thumb", 0);
        self.write_line("", 0);
        self.write_line(".section .text", 0);
        self.write_line(".global _start", 0);
        self.write_line(".type _start, %function", 0);
        self.write_line("", 0);
    }

    fn write_line(&mut self, string: &str, indents: usize) {
        let indent_str = "    ".repeat(indents);

        // writeln! automatically appends \n
        let _ = writeln!(self.file, "{}{}", indent_str, string);
    }

    fn emit(&mut self, func: Function) {
        match func.name.as_str() {
            "main" => self.emit_main(func),
            _ => self.emit_func(func),
        }
        self.file.sync_all().unwrap();
    }

    fn emit_func(&mut self, func: Function) {}

    fn emit_main(&mut self, func: Function) {
        self.write_line("_start:", 0);

        if self.hard {
            self.write_line("mov r9, #0", 1); // step counter in register
            self.write_line("mov r10, #1", 1); // step counter in register
        }
        self.emit_block(func.body, true);
        if self.hard {
            self.emit_countermeasure();
        }
        self.write_line("\n.size _start, .-_start", 0);
    }
    fn emit_block(&mut self, block: Block, is_main: bool) {
        let initial_offset = self.stack_offset;
        let initial_locals = self.locals.clone();

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
            if self.hard {
                self.emit_step_check();
            }
        }

        let offset_diff = self.stack_offset - initial_offset;
        if offset_diff > 0 && !has_return {
            self.write_line(&format!("add sp, sp, #{}", offset_diff), 1);
        }

        self.stack_offset = initial_offset;
        self.locals = initial_locals;
    }
    fn emit_countermeasure(&mut self) {
        self.write_line("countermeasure:", 0);

        // exit(77)
        self.write_line("mov r0, #77", 1);
        self.write_line("mov r7, #1", 1);
        self.write_line("svc #0", 1);
    }

    fn emit_step_check(&mut self) {
        if !self.hard {
            return;
        }

        self.write_line("add r9, r9, #1", 1);
        self.write_line("cmp r9, r10", 1);
        self.write_line("bne countermeasure", 1);
        self.write_line("add r10, r10, #1", 1);
    }

    fn emit_print_data(&mut self) {
        if self.string_literals.is_empty() && !self.need_int_print {
            return;
        }
        self.write_line("", 0);
        self.write_line(".section .data", 0);

        // clone string literals to avoid borrow conflicts while writing
        let literals = self.string_literals.clone();
        for (label, contents) in literals {
            self.write_line(&format!("{}:", label), 0);
            self.write_line(&format!(".ascii \"{}\"", contents), 1);
        }
        if self.need_int_print {
            self.write_line("newline:", 0);
            self.write_line(".ascii \"\\n\"", 1);
            self.write_line("num_buf:", 0);
            self.write_line(".space 16", 1);
        }
        if self.hard {
            self.write_line("step_counter:", 0);
            self.write_line(".word 0", 1);
            self.write_line("fault_msg:", 0);
            self.write_line(".ascii \"Control flow violation detected\\n\"", 1);
        }
    }
    fn emit_if(&mut self, if_stmt: Stmt) {
        match if_stmt {
            Stmt::If { condition, block, option } => {
                let label_id = self.label_count;
                self.label_count += 1;

                self.emit_expr(condition);
                self.write_line("cmp r0, #0", 1);
                self.write_line(&format!("beq else_{}", label_id), 1);

                // save step state
                let saved = self.step_counter;

                // THEN branch
                self.emit_step_check();
                self.emit_block(block, false);
                let then_end = self.step_counter;

                self.write_line(&format!("b endif_{}", label_id), 1);

                // ELSE branch
                self.write_line(&format!("else_{}:", label_id), 0);

                self.step_counter = saved;

                if let Some(else_block) = option {
                    self.emit_step_check();
                    self.emit_block(else_block, false);
                }

                let else_end = self.step_counter;
                self.write_line(&format!("endif_{}:", label_id), 0);
                self.step_counter = then_end.max(else_end);
            }
            _ => panic!("emit_if called with non-if statement"),
        }
    }

    fn emit_while(&mut self, while_stmt: Stmt) {
        match while_stmt {
            Stmt::While { expr, block } => {
                let label_id = self.label_count;
                self.label_count += 1;

                self.write_line(&format!("while_{}:", label_id), 0);

                self.emit_step_check();
                self.emit_expr(expr);
                self.write_line("cmp r0, #0", 1);
                self.write_line(&format!("beq end_while_{}", label_id), 1);

                self.emit_block(block, false);
                self.emit_step_check();

                self.write_line(&format!("b while_{}", label_id), 1);
                self.write_line(&format!("end_while_{}:", label_id), 0);
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
                    self.write_line("mov r0, #1", 1);
                    self.write_line(&format!("ldr r1, ={}", label), 1);
                    self.write_line(&format!("mov r2, #{}", inner.len()), 1);
                    self.write_line("mov r7, #4", 1);
                    self.write_line("svc #0", 1);
                }
                other => {
                    // Print integer value; newline only after the last argument
                    self.need_int_print = true;
                    self.emit_expr(other);

                    let id = self.label_count;
                    self.label_count += 1;

                    // r0 holds value to print
                    self.write_line("mov r4, r0", 1);
                    self.write_line("ldr r1, =num_buf", 1);
                    self.write_line("add r1, r1, #16", 1);
                    self.write_line("mov r2, #0", 1);

                    // handle zero specially
                    self.write_line("cmp r4, #0", 1);
                    self.write_line(&format!("bne print_int_loop_{}", id), 1);
                    self.write_line("mov r3, #48", 1);
                    self.write_line("sub r1, r1, #1", 1);
                    self.write_line("strb r3, [r1]", 1);
                    self.write_line("mov r2, #1", 1);
                    self.write_line(&format!("b print_int_done_{}", id), 1);

                    // conversion loop
                    self.write_line(&format!("print_int_loop_{}:", id), 0);
                    self.write_line("mov r0, r4", 1);
                    self.write_line("mov r3, #10", 1);
                    self.write_line("sdiv r5, r0, r3", 1); // r5 = value / 10
                    self.write_line("mul r6, r5, r3", 1); // r6 = (value/10)*10
                    self.write_line("sub r7, r0, r6", 1); // r7 = value % 10
                    self.write_line("add r7, r7, #48", 1); // to ASCII
                    self.write_line("sub r1, r1, #1", 1);
                    self.write_line("strb r7, [r1]", 1);
                    self.write_line("add r2, r2, #1", 1);
                    self.write_line("mov r4, r5", 1); // value = value / 10
                    self.write_line("cmp r4, #0", 1);
                    self.write_line(&format!("bne print_int_loop_{}", id), 1);

                    self.write_line(&format!("print_int_done_{}:", id), 0);
                    // write digits
                    self.write_line("mov r0, #1", 1);
                    self.write_line("mov r1, r1", 1);
                    self.write_line("mov r2, r2", 1);
                    self.write_line("mov r7, #4", 1);
                    self.write_line("svc #0", 1);

                    // newline only once, after the last printed value
                    if is_last {
                        self.write_line("mov r0, #1", 1);
                        self.write_line("ldr r1, =newline", 1);
                        self.write_line("mov r2, #1", 1);
                        self.write_line("mov r7, #4", 1);
                        self.write_line("svc #0", 1);
                    }
                }
            }
        }
    }

    fn emit_return(&mut self, return_stmt: Stmt, is_main: bool) {
        match return_stmt {
            Stmt::Return(expr) => {
                self.emit_expr(expr);
                self.write_line("mov r7, #1", 1);
                self.write_line("svc #0", 1);
            }
            _ => panic!("return poorly formed"),
        }
    }
    fn emit_assign(&mut self, assign_stmt: Stmt) {
        match assign_stmt {
            Stmt::AssignStatement(name, expr) => {
                self.emit_expr(expr);
                let offset = self.locals.get(&name).expect("Undefined variable");
                if self.stack_offset - offset == 0 {
                    self.write_line(&format!("str r0, [sp]"), 1);
                } else {
                    self.write_line(&format!("str r0, [sp, #{}]", self.stack_offset - offset), 1);
                }
                if self.hard {
                    self.emit_step_check();
                }
            }
            _ => panic!("Not a valid assignment"),
        }
    }
    fn emit_let(&mut self, let_stmt: Stmt) {
        match let_stmt {
            Stmt::Let(name, type_name, expr) => {
                self.stack_offset += 4;
                self.write_line("sub sp, sp, #4", 1);
                self.emit_expr(expr);
                self.write_line("str r0, [sp]", 1);
                self.locals.insert(name, self.stack_offset);
                if self.hard {
                    self.emit_step_check();
                }
            }
            _ => panic!("Not a let statement format sorry "),
        }
    }
    fn emit_expr(&mut self, expr: Expr) {
        match expr {
            Expr::IntegerLiteral(val) => self.write_line(&format!("mov r0, #{}", val), 1),
            Expr::BooleanLiteral(val) => {
                if val {
                    self.write_line(&format!("mov r0, #{}", 1), 1)
                } else {
                    self.write_line(&format!("mov r0, #{}", 0), 1)
                }
            }
            Expr::Identifier(name) => {
                let offset = self.locals.get(&name).expect("Undefined variable");
                self.write_line(&format!("ldr r0, [sp, #{}]", self.stack_offset - offset), 1);
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
                self.write_line("mov r1, r0", 1); // store left
                self.emit_expr(*right);

                match op {
                    BinOp::Add => self.write_line("add r0, r1, r0", 1),
                    BinOp::Sub => self.write_line("sub r0, r1, r0", 1),
                    BinOp::Mul => self.write_line("mul r0, r1, r0", 1),
                    BinOp::Div => self.write_line("sdiv r0, r1, r0", 1),

                    BinOp::Equals => {
                        self.write_line("cmp r1, r0", 1);
                        self.write_line("mov r0, #0", 1);
                        self.write_line("it eq", 1);
                        self.write_line("moveq r0, #1", 1);
                    }

                    BinOp::NotEquals => {
                        self.write_line("cmp r1, r0", 1);
                        self.write_line("mov r0, #0", 1);
                        self.write_line("it ne", 1);
                        self.write_line("movne r0, #1", 1);
                    }

                    BinOp::GreaterThan => {
                        self.write_line("cmp r1, r0", 1);
                        self.write_line("mov r0, #0", 1);
                        self.write_line("it gt", 1);
                        self.write_line("movgt r0, #1", 1);
                    }

                    BinOp::LessThan => {
                        self.write_line("cmp r1, r0", 1);
                        self.write_line("mov r0, #0", 1);
                        self.write_line("it lt", 1);
                        self.write_line("movlt r0, #1", 1);
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
            .open("temp/tests/test_can_generate_init.asm")
            .expect("Failed to create file: /temp/tests/test_can_generate_init.asm");

        let ast = AST::new();
        let mut codegen = CodeGenerator::new(output_file);
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
            .open("temp/tests/test_can_generate_return.asm")
            .expect("Failed to create file: /temp/tests/test_can_generate_return.asm");
        let mut codegen = CodeGenerator::new(output_file);
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
            .open("temp/tests/test_can_generate_let.asm")
            .expect("Failed to create file: /temp/tests/test_can_generate_let.asm");
        let mut codegen = CodeGenerator::new(output_file);
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
            .open("temp/tests/test_can_generate_if_else.asm")
            .expect("Failed to create file: /temp/tests/test_can_generate_if_else.asm");
        let mut codegen = CodeGenerator::new(output_file);
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
            .open("temp/tests/test_can_generate_while.asm")
            .expect("Failed to create file: /temp/tests/test_can_generate_while.asm");
        let mut codegen = CodeGenerator::new(output_file);
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
            .open("temp/tests/test_can_generate_two_whiles.asm")
            .expect("Failed to create file: /temp/tests/test_can_generate_two_whiles.asm");
        let mut codegen = CodeGenerator::new(output_file);
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
            .open("temp/tests/test_can_generate_nested_while.asm")
            .expect("Failed to create file: /temp/tests/test_can_generate_nested_while.asm");
        let mut codegen = CodeGenerator::new(output_file);
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
            let output_asm_path = format!("temp/tests/{}.asm", file_stem);
            let output_file = File::options()
                .read(true)
                .write(true)
                .create(true)
                .truncate(true)
                .open(&output_asm_path)
                .expect(&format!("Failed to create file: {}", output_asm_path));

            let mut codegen = CodeGenerator::new(output_file);
            codegen.generate(ast, false);

            let output_path = trv_path.with_extension("trv.output");
            let expected_exit_code = std::fs
                ::read_to_string(&output_path)
                .expect("Failed to read output file")
                .trim()
                .parse::<i32>()
                .expect("Failed to parse exit code");

            let result = std::process::Command::new("./run_asm").arg(&output_asm_path).output();

            let actual_exit_code = match result {
                Ok(output) => output.status.code().unwrap_or(-1),
                Err(_) => -1,
            };

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
