use std::process::exit;

use clap::Parser;
use thumb2_interpreter::interpreter::Interpreter;

/// A Thumb2 interpreter
#[derive(Parser, Debug, Clone, PartialEq, Eq)]
#[command(version, about, long_about = None)]
struct Args {
    file_path: String,

    #[arg(short, long)]
    debug: bool,

    #[arg(long)]
    max_time: Option<u128>,

    #[arg(short, long)]
    injection_point: Option<String>,

    #[arg(long)]
    test_mode: bool
}

fn main() {
    let args = Args::parse();

    let mut interpreter = Interpreter::default();
    
    interpreter.set_debug(args.debug);
    interpreter.set_test_mode(args.test_mode);
    if let Some(time) = args.max_time {
        interpreter.set_max_time(time);
    }
    
    interpreter.read_file(&args.file_path);
    if let Some(injection_point) = args.injection_point {
        interpreter.inject(injection_point);
    }
    
    let return_code = interpreter.execute();
    exit(return_code as i32)
}
