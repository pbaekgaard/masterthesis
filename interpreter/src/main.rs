use std::env;
use Thumb2Interpreter::interpreter::Interpreter;

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        eprintln!("Error: Please provide a Trivilang Thumb2 Source Code File");
        std::process::exit(1);
    }

    let debug = if args.iter().any(|a| a == "--debug" || a == "-d") {
        true
    } else if args.iter().any(|a| a == "--release-debug" || a == "-r") {
        false
    } else {
        cfg!(debug_assertions)
    };

    let file_path = &args[1];
    let mut interpreter = Interpreter::default();
    interpreter.set_debug(debug);
    interpreter.read_file(file_path);
    interpreter.print_memory();
    let return_code = interpreter.execute();
    interpreter.print_memory();
    println!("Execution returned with return_code {return_code}")
}
