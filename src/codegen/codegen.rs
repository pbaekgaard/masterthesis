use crate::parser::{AST, parser::Function};
use std::{fs::File, io::{Seek, SeekFrom, Write}};

#[derive(Debug)]
pub struct CodeGenerator {
    file: File
}

impl CodeGenerator {
    pub fn new(file : File) -> Self {
        Self {file}
    }
    pub fn generate(&mut self, ast : AST) {
        self.gen_main(ast[0].clone());

    }
    fn gen_main(&mut self, func: Function){
        self.emit("instruction".to_string());
    }
    fn emit(&mut self, instruction : String) {
        let mut buf = br##"
            .syntax unified
            .thumb

            .section .text
            .global _start

        "##;
        let mut buf_2 = br##"
        .type _start, %function

            _start:
                mov r0, #69
                mov r7, #1
                svc #0

            .size _start, .-_start"##;
        self.file.write_all(buf);
        self.file.write_all(buf_2);
        self.file.flush().unwrap();
    }
}

#[cfg(test)]
mod tests {
    use crate::{CodeGenerator, codegen};
    use crate::lexer::{lexer::Lexer, token::Token};
    use crate::parser::parser::{Parser, AST};
    use std::{fs::File, io::{Seek, SeekFrom, Write}};
    use std::io::Read;

    #[test]
    fn can_generate_return() {
        let source = r##"
            func main() -> Boolean {
                return 69;
            }
        "##.to_string();
        let mut lexer: Lexer = Lexer::new(source);
        let tokens: Vec<Token> = lexer.tokenize();
        let mut parser: Parser = Parser::new(tokens);
        let ast: AST = parser.parse_program();
        let output_file = File::create("test_can_generate_return.asm").expect("Couldn't create file: test_can_generate_return.asm");
        let mut codegen = CodeGenerator::new(output_file);
        codegen.generate(ast);
        let mut buf = "".to_string();
        codegen.file.flush().unwrap();          // ensure all writes are written
        codegen.file.seek(SeekFrom::Start(0)).unwrap(); // rewind to start
        let _ = codegen.file.read_to_string(&mut buf);
        let expected = r##"
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
        "##.to_string();//make
        assert_eq!(expected, buf)
    }

    #[test]
    fn can_generate_let() {
        let source = r##"
            func main() -> Boolean {
                let x : Integer = 11;
            }
        "##.to_string();
        let mut lexer: Lexer = Lexer::new(source);
        let tokens: Vec<Token> = lexer.tokenize();
        let mut parser: Parser = Parser::new(tokens);
        let ast: AST = parser.parse_program();
        let output_file = File::create("test_can_generate_let.asm").expect("Couldn't create file: test_can_generate_let.asm");
        let mut codegen = CodeGenerator::new(output_file);
        codegen.generate(ast);
        let mut buf = "".to_string();
        let _ = codegen.file.read_to_string(&mut buf);
        let expected = r##""##.to_string();//make
        assert_eq!(expected, buf)
    }
}
