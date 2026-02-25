use crate::parser::{AST, parser::{Block, Function, Stmt}};
use std::{fs::File, io::Write};

#[derive(Debug)]
pub struct CodeGenerator {
    pub file: File,
}

impl CodeGenerator {
    pub fn new(file: File) -> Self {
        Self { file }
    }
    pub fn generate(&mut self, ast: AST) {
        self.gen_init();
        for func in ast {
            self.emit(func);
        }
    }

    fn gen_init(&mut self) {
        self.write_line(".syntax unified",0);
        self.write_line(".thumb",0);
        self.write_line(".section .text",0);
        self.write_line(".global _start",0);
        self.write_line(".type _start, %function",0);
    }

    fn write_line(&mut self, string: &str, indents: usize) {
        // Create indentation (e.g., 4 spaces per indent level)
        let indent_str = "\t".repeat(indents);

        // writeln! automatically appends \n
        let _ = writeln!(self.file, "{}{}", indent_str, string);
    }

    fn emit(&mut self, func: Function) {
        match func.name.as_str() {
            "main" => self.emit_main(func),
            _ => panic!("failed"),
        }
        self.file.sync_all().unwrap();
    }

    fn emit_main(&mut self, func: Function) {
        self.write_line("_start:",0);
        self.emit_block(func.body, true);
    }
    fn emit_block(&mut self, block: Block, is_main: bool){
        for stmt in block.statements{
            match stmt {
                Stmt::Return(expr) => {
                    expr
                }
                _ => panic!("Block fucking wrong")
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use crate::lexer::{lexer::Lexer, token::Token};
    use crate::parser::parser::{Parser, AST};
    use crate::CodeGenerator;
    use std::fs::{File, OpenOptions};
    use std::io::{Read, Seek, SeekFrom};
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
        let expected = indoc::indoc! {r##"
            .syntax unified
            .thumb
            .section .text
            .global _start
            .type _start, %function
            "##}.to_string();
        assert_eq!(expected, buf);

    }

    #[test]
    fn can_generate_return() {
        initialize();
        let source = std::fs::read_to_string("test_codes/test_main_return.trv")
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
        let expected = indoc::indoc! {r##"
            .syntax unified
            .thumb

            .section .text
            .global _start
            .type _start, %function

            _start:
                mov r0, #69
                mov r7, #1
                svc #0

            .size _start, .-_start"##}
        .to_string();
        assert_eq!(expected, buf)
    }
}
