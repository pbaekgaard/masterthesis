use crate::parser::{ AST, parser::{ BinOp, Block, Expr, Function, Stmt } };
use core::panic;
use std::{ collections::HashMap, fs::File, io::Write };

#[derive(Debug)]
pub struct CodeGenerator {
    pub file: File,
    locals: HashMap<String, i32>,
    stack_offset: i32,
    label_count: usize,
}

impl CodeGenerator {
    pub fn new(file: File) -> Self {
        Self {
            file,
            locals: HashMap::new(),
            stack_offset: 0,
            label_count: 0,
        }
    }
    pub fn generate(&mut self, ast: AST) {
        self.gen_init();
        for func in ast {
            self.emit(func);
        }
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
        // Create indentation (e.g., 4 spaces per indent level)
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
        self.emit_block(func.body, true);
        self.write_line("\n.size _start, .-_start", 0);
    }
    fn emit_block(&mut self, block: Block, is_main: bool) {
        for stmt in block.statements {
            match stmt {
                Stmt::Let(_, _, _) => self.emit_let(stmt),
                Stmt::AssignStatement(_, _) => self.emit_assign(stmt),
                Stmt::Return(_) => self.emit_return(stmt, is_main),
                Stmt::If { .. } => self.emit_if(stmt),
                _ => panic!("Error found in expression in return"),
            }
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

                // then block
                self.emit_block(block, false);
                self.write_line(&format!("b endif_{}", label_id), 1);

                // else block
                self.write_line(&format!("else_{}:", label_id), 0);
                if let Some(else_block) = option {
                    self.emit_block(else_block, false);
                }

                self.write_line(&format!("endif_{}:", label_id), 0);
            }
            _ => panic!("emit_if called with non-if statement"),
        }
    }

    fn emit_return(&mut self, return_stmt: Stmt, is_main: bool) {
        match return_stmt {
            Stmt::Return(expr) => {
                match expr {
                    | crate::parser::parser::Expr::IntegerLiteral(_)
                    | crate::parser::parser::Expr::Identifier(_) => {
                        self.emit_expr(expr);
                    }
                    _ => panic!("Unsupported expression type in return"),
                }
                if is_main {
                    self.write_line("mov r7, #1", 1);
                    self.write_line("svc #0", 1);
                } else {
                    self.write_line("bx lr", 1);
                }
            }
            _ => panic!("return poorly formed"),
        }
    }
    fn emit_assign(&mut self, assign_stmt: Stmt) {
        match assign_stmt {
            Stmt::AssignStatement(name, expr) => {
                self.emit_expr(expr);
                let offset = self.locals.get(&name).expect("Undefined variable");
                if self.stack_offset - offset == 0{
                    self.write_line(&format!("str r0, [sp]"), 1);
                }else{
                    self.write_line(&format!("str r0, [sp, #{}]", self.stack_offset - offset), 1);
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
            }
            _ => panic!("Not a let statement format sorry "),
        }
    }
    fn emit_expr(&mut self, expr: Expr) {
        match expr {
            Expr::IntegerLiteral(val) => { self.write_line(&format!("mov r0, #{}", val), 1) }
            Expr::BooleanLiteral(val) => { self.write_line(&format!("mov r0, #{}", val), 1) }
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
        codegen.generate(ast);
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
        codegen.generate(ast);
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
        codegen.generate(ast);
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
            ::read_to_string("test_codes/test_func_if_else.trv")
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
            .expect("Failed to create file: /temp/tests/test_can_generate_let.asm");
        let mut codegen = CodeGenerator::new(output_file);
        codegen.generate(ast);
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
}
