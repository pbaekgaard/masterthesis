mod codegen;
mod lexer;
mod parser;
mod semantic;

use lexer::lexer::Lexer; // adjust if needed
use lexer::token::Token;
use parser::parser::AST;
use parser::parser::Parser;
use std::env;
use std::fs;

use crate::codegen::codegen::CodeGenerator;

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        eprintln!("Usage: triviC <filename>");
        std::process::exit(1);
    }

    let filename = &args[1];

    let source = fs::read_to_string(filename).expect("Failed to read file");

    let mut lexer: Lexer = Lexer::new(source);
    let tokens: Vec<Token> = lexer.tokenize();
    let mut parser: Parser = Parser::new(tokens);
    let ast: AST = parser.parse_program();
    println!("Lexing and parsing completed successfully.");
    let codegen = CodeGenerator::new();
    codegen.generate(ast);
}
