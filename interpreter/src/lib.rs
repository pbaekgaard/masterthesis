pub mod interpreter;
pub mod memory;

#[cfg(test)]
mod tests {
    use super::interpreter::Interpreter;
    use std::path::PathBuf;

    fn get_test_file_path(filename: &str) -> PathBuf {
        PathBuf::from(env!("CARGO_MANIFEST_DIR"))
            .join("test_files")
            .join(filename)
    }

    #[test]
    fn test_interpret_test_let() {
        let mut interp = Interpreter::new();
        interp.read_file(
            &mut get_test_file_path("test_let.asm")
                .to_string_lossy()
                .to_string(),
        );
        let exit_code = interp.execute();
        assert_eq!(exit_code, 27, "test_let.asm should exit with 27");
    }

    #[test]
    fn test_interpret_test_stack() {
        let mut interp = Interpreter::new();
        interp.read_file(
            &mut get_test_file_path("test_stack.asm")
                .to_string_lossy()
                .to_string(),
        );
        let exit_code = interp.execute();
        assert_eq!(exit_code, 42, "test_stack.asm should exit with 42");
    }

    #[test]
    fn test_interpret_test_branching() {
        let mut interp = Interpreter::new();
        interp.read_file(
            &mut get_test_file_path("test_branching.asm")
                .to_string_lossy()
                .to_string(),
        );
        let exit_code = interp.execute();
        assert_eq!(exit_code, 12, "test_branching.asm should exit with 12");
    }
}
