use crate::parser::AST;
use std::fs::File;

#[derive(Debug)]
pub struct CodeGenerator {
    file: File
}

impl CodeGenerator {
    pub fn new(file : File) -> Self {
        Self {file}
    }
    pub fn generate(&self, ast : AST) {

    }

    fn emit(&self, instruction : String) {

    }
}

#[cfg(test)]
mod tests {
    use crate::{CodeGenerator, codegen};
    use crate::lexer::{lexer::Lexer, token::Token};
    use crate::parser::parser::{Parser, AST};
    use std::fs::File;

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

        let codegen = CodeGenerator::new(output_file);
        codegen.generate(ast);
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
        let codegen = CodeGenerator::new(output_file);
    }
}
