mod parser;
mod lexer;
mod semantic;

use std::env;
use std::fs;
use lexer::token::Token;
use lexer::lexer::Lexer; // adjust if needed
use parser::parser::AST;
use parser::parser::Parser;

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 3 {
        eprintln!("Usage: triviC <filename>");
        std::process::exit(1);
    }

    let filename = &args[2];

    let source = fs::read_to_string(filename)
        .expect("Failed to read file");

    let mut lexer: Lexer = Lexer::new(source);
    let _tokens: Vec<Token> = lexer.tokenize();
    let mut parser: Parser = Parser::new(_tokens);
    let _ast: AST = parser.parse_program();

    println!("Lexing and parsing completed successfully.");
}

#[cfg(test)]
mod tests{
    use pretty_assertions::{assert_eq};
    #[test]
    fn zero_eq_zero(){
        assert_eq!(0,0);
    }
}