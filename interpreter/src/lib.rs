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
    #[test]
    fn test_ite_condition_true() {
        let mut interp = Interpreter::new();
        interp.read_file(&get_test_file_path("test_ite_true.asm").to_string_lossy().to_string());
        let exit_code = interp.execute();
        assert_eq!(exit_code, 1, "ITE True: T should have run, result 1");
    }

    #[test]
    fn test_ite_condition_false() {
        let mut interp = Interpreter::new();
        interp.read_file(&get_test_file_path("test_ite_false.asm").to_string_lossy().to_string());
        let exit_code = interp.execute();
        assert_eq!(exit_code, 2, "ITE False: E should have run, result 2");
    }

    #[test]
    fn test_ittete_condition_true() {
        let mut interp = Interpreter::new();
        interp.read_file(&get_test_file_path("test_ittete_true.asm").to_string_lossy().to_string());
        let exit_code = interp.execute();
        assert_eq!(exit_code, 211, "ITTETE True: Only T instructions should sum");
    }

    #[test]
    fn test_ittete_condition_false() {
        let mut interp = Interpreter::new();
        interp.read_file(&get_test_file_path("test_ittete_false.asm").to_string_lossy().to_string());
        let exit_code = interp.execute();
        assert_eq!(exit_code, 103, "ITTETE False: Only E instructions should sum");
    }
}
