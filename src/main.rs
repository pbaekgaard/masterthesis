mod parser;
mod lexer;
mod semantic;

use clap::Parser as Psr;
use std::fs;
use lexer::token::Token;
use lexer::lexer::Lexer; // adjust if needed
use parser::parser::AST;
use parser::parser::Parser;

/// The triviC compiler
#[derive(Psr, Debug)]
#[command(name = "triviC", version, about = "Lexes and parses triviC source files", long_about = None)]
struct Args {
    /// The source file to compile
    filename: String,
}

fn main() {
    // This entirely replaces the manual env::args() collection, 
    // the length check, and the manual error/exit logic.
    let args = Args::parse();

    let source = fs::read_to_string(&args.filename)
        .expect("Failed to read file");

    let mut lexer: Lexer = Lexer::new(source);
    let _tokens: Vec<Token> = lexer.tokenize();
    let mut parser: Parser = Parser::new(_tokens);
    let _ast: AST = parser.parse_program();

    println!("Lexing and parsing completed successfully.");
}
