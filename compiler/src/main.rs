mod codegen;
mod parser;
mod lexer;
mod semantic;

use clap::Parser as Psr;
use std::fmt::format;
use std::fs;
use std::fs::File;
use std::string;
use lexer::token::Token;
use lexer::lexer::Lexer; // adjust if needed
use parser::parser::AST;
use parser::parser::Parser;
use codegen::codegen::CodeGenerator;


/// The triviC compiler
#[derive(Psr, Debug)]
#[command(name = "triviC", version, about = "Lexes and parses triviC source files", long_about = None)]
struct Args {
    /// The source file to compile
    filename: String,

    #[arg(short, long, default_value = "out.asm")]
    output: String,
    
    #[arg(long)]
    hard: bool,

    #[arg(long, default_value = "wh_out.wh")]
    wh_output: String
}

fn main() {
    let args = Args::parse();

    let source = fs::read_to_string(&args.filename)
        .expect("Failed to read file");

    let output = File::options()
        .read(true)
        .write(true)
        .create(true)
        .truncate(true)
        .open(&args.output)
        .expect(&format!("wrongdog output path {}", args.output));
    
    let wh_output = File::options()
        .read(true)
        .write(true)
        .create(true)
        .truncate(true)
        .open(&args.wh_output)
        .expect(&format!("wrong whiley output path: {}", args.wh_output));

    let mut lexer: Lexer = Lexer::new(source);
    let _tokens: Vec<Token> = lexer.tokenize();
    let mut parser: Parser = Parser::new(_tokens);
    let _ast: AST = parser.parse_program();
    let mut codegen: CodeGenerator = CodeGenerator::new(output,wh_output);
    codegen.generate(_ast, args.hard);
    

    println!("Lexing and parsing completed successfully.");
}
