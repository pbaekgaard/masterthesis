use crate::parser::AST;

#[derive(Debug)]
pub struct CodeGenerator {}

impl CodeGenerator {
    pub fn new() -> Self {
        Self {}
    }
    pub fn generate(&self, ast : AST) {

    }

    fn emit(&self, instruction : String) {

    }
}

#[cfg(test)]
mod tests {
    use crate::CodeGenerator;
    use crate::lexer::{lexer::Lexer, token::Token};
    use crate::parser::parser::{Parser, AST};

    #[test]
    fn can_generate_print() {
        let source = r##"
            func main() -> Boolean {
                print("hello world");
            }
        "##.to_string();
        let mut lexer: Lexer = Lexer::new(source);
        let tokens: Vec<Token> = lexer.tokenize();
        let mut parser: Parser = Parser::new(tokens);
        let ast: AST = parser.parse_program();
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
    }
}
