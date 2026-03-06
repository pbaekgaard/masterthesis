use clap::Parser;
use thumb2_interpreter::interpreter::Interpreter;

/// A Thumb2 interpreter
#[derive(Parser, Debug, Clone, PartialEq, Eq)]
#[command(version, about, long_about = None)]
struct Args {
    /// The file path to read
    file_path: String,

    /// Enable debug output
    #[arg(short, long)]
    debug: bool,

    /// Stop execution after N nanoseconds
    #[arg(long)]
    max_time: Option<u128>,
}

fn main() {
    // clap's Parser trait provides the parse() method. 
    // If the user passes invalid args or -h/--help, clap automatically 
    // prints the error/help message and exits the program safely.
    let args = Args::parse();

    let mut interpreter = Interpreter::default();
    
    interpreter.set_debug(args.debug);
    
    if let Some(time) = args.max_time {
        interpreter.set_max_time(time);
    }
    
    interpreter.read_file(&args.file_path);
    interpreter.print_memory();
    
    let return_code = interpreter.execute();
    
    interpreter.print_memory();
    println!("Execution returned with return_code {return_code}");
}
