use std::{collections::HashMap, fs::File, io::BufRead};

use crate::memory::EmulatorMemory;

pub struct Interpreter {
    memory: EmulatorMemory,
    file: Vec<String>,
    debug: bool,
}

impl Interpreter {
    pub fn new() -> Self {
        Self {
            memory: EmulatorMemory::new(),
            file: Vec::new(),
            debug: false,
        }
    }

    pub fn set_debug(&mut self, debug: bool) {
        self.debug = debug;
    }
    pub fn read_file(&mut self, file_path: &String) -> bool {
        let file = File::open(file_path).expect("Could not open file: {file_path}");
        let lines: Vec<String> = std::io::BufReader::new(file)
            .lines()
            .map(|line| line.expect("Could not read line from file"))
            .collect();
        self.file = lines;
        true
    }

    pub fn print_registers(&self) {
        if self.debug {
            self.memory.print_registers();
        }
    }

    pub fn print_memory(&self) {
        if !self.debug {
            return;
        }
        println!("╔══════════════════════════════════════════════════════════════════╗");
        println!("║                        MEMORY STATE                              ║");
        println!("╠══════════════════════════════════════════════════════════════════╣");

        println!("║ REGISTERS:                                                       ║");
        println!("╟──────────────────────────────────────────────────────────────────╢");
        for (i, &value) in self.memory.get_registers().iter().enumerate() {
            if i % 4 == 0 {
                print!("║ ");
            }
            if i < 10 {
                print!("r{} : {:<10} ", i, value);
            } else {
                print!("r{}: {:<10} ", i, value);
            }
            if i % 4 == 3 {
                println!(" ║");
            }
        }
        if 32 % 4 != 0 {
            println!("║");
        }

        println!("╟──────────────────────────────────────────────────────────────────╢");
        println!("║ STACK POINTER:                                                   ║");
        println!(
            "║   SP: {:>10} (0x{:08x})                                    ║",
            self.memory.get_sp(),
            self.memory.get_sp()
        );

        println!("╟──────────────────────────────────────────────────────────────────╢");
        println!("║ HEAP:                                                            ║");
        println!(
            "║   Heap allocated: {:>6} bytes                                   ║",
            self.memory.get_heap_alloc_index()
        );
        println!(
            "║   Heap size:     {:>6} bytes                                   ║",
            self.memory.get_heap_size()
        );

        let heap_data = self.memory.get_heap();
        if self.memory.get_heap_alloc_index() > 0 {
            println!("║   Heap contents (first 256 bytes):                              ║");
            let display_len = std::cmp::min(256, self.memory.get_heap_alloc_index());
            for row in (0..display_len).step_by(16) {
                let end = std::cmp::min(row + 16, display_len);
                print!("║   {:04x}: ", row);
                for i in row..end {
                    print!("{:02x} ", heap_data[i]);
                }
                for _ in end..row + 16 {
                    print!("   ");
                }
                print!(" |");
                for i in row..end {
                    let byte = heap_data[i];
                    if byte >= 32 && byte < 127 {
                        print!("{}", byte as char);
                    } else {
                        print!(".");
                    }
                }
                for _ in end..row + 16 {
                    print!(" ");
                }
                println!("|║");
            }
        }

        println!("╟──────────────────────────────────────────────────────────────────╢");
        println!("║ STACK:                                                           ║");
        println!(
            "║   Stack size: {:>6} bytes                                       ║",
            self.memory.get_stack().len()
        );
        println!(
            "║   SP: {:>10} (0x{:08x})                                    ║",
            self.memory.get_sp(),
            self.memory.get_sp()
        );

        let stack_data = self.memory.get_stack();
        let sp = self.memory.get_sp();
        let display_start = sp.saturating_sub(64);
        let display_end = std::cmp::min(sp + 64, stack_data.len());
        if display_end > 0 {
            println!("║   Stack contents (from sp-64 to sp+64):                         ║");
            for row in (display_start..display_end).step_by(16) {
                let end = std::cmp::min(row + 16, display_end);
                print!("║   {:04x}: ", row);
                for i in row..end {
                    print!("{:02x} ", stack_data[i]);
                }
                for _ in end..row + 16 {
                    print!("   ");
                }
                print!(" |");
                for i in row..end {
                    let byte = stack_data[i];
                    if byte >= 32 && byte < 127 {
                        print!("{}", byte as char);
                    } else {
                        print!(".");
                    }
                }
                for _ in end..row + 16 {
                    print!(" ");
                }
                println!("|║");
            }
        }

        println!("╚══════════════════════════════════════════════════════════════════╝");
    }

    pub fn shout_file(self) {
        println!("------------------- SHOUT FILE START -------------------");
        for (idx, line_content) in self.file.iter().enumerate() {
            println!("Line {idx}, Content: {line_content}");
        }
        println!("-------------------- SHOUT FILE END --------------------");
    }

    fn get_asm_branches(&self) -> HashMap<String, Vec<String>> {
        let mut branches: HashMap<String, Vec<String>> = HashMap::new();
        let mut current_branch: Option<String> = None;
        let mut current_instructions: Vec<String> = Vec::new();

        for line in &self.file {
            let trimmed = line.trim();

            if trimmed.ends_with(":") && !trimmed.starts_with("    ") {
                if let Some(branch_name) = current_branch {
                    branches.insert(branch_name, current_instructions.clone());
                    current_instructions.clear();
                }
                current_branch = Some(trimmed.trim_end_matches(':').to_string());
            } else if current_branch.is_some() && line.starts_with("    ") {
                current_instructions.push(trimmed.to_string());
            }
        }

        if let Some(branch_name) = current_branch {
            branches.insert(branch_name, current_instructions);
        }

        branches
    }

    fn exec_mov(&mut self, content: String) {
        if self.debug {
            println!("Executing mov instruction: {}", content);
        }
        let parts: Vec<&str> = content.split_whitespace().collect();
        let dest = parts[1].replace(",", "");
        let src = parts[2].replace(",", "");

        let dest_idx: usize = dest[1..].parse().expect("Failed to parse register index");
        let value: u32;

        if let Some(value_str) = src.strip_prefix('#') {
            value = value_str.parse().expect("Failed to parse immediate value");
            self.memory.set_reg(dest_idx, value);
            if self.debug {
                println!("Mock: mov r{}, #{} (stored in register)", dest_idx, value);
            }
        } else {
            let src_idx: usize = src[1..].parse().expect("Failed to parse register index");
            value = self.memory.get_reg(src_idx);
            self.memory.set_reg(dest_idx, value);
            if self.debug {
                println!(
                    "Mock: mov r{}, r{} (register to register)",
                    dest_idx, src_idx
                );
            }
        }
    }

    fn exec_svc(&mut self, content: String) -> Option<u32> {
        if self.debug {
            println!("Executing svc instruction: {}", content);
        }

        let parts: Vec<&str> = content.split_whitespace().collect();
        if let Some(svc_num) = parts.get(1) {
            let svc_num = svc_num.replace("#", "");
            if svc_num == "0" {
                let syscall_num = self.memory.get_reg(7);
                if syscall_num == 1 {
                    let exit_code = self.memory.get_reg(0);
                    if self.debug {
                        println!("Exit syscall (r7=1), returning exit code: {}", exit_code);
                    }
                    return Some(exit_code);
                }
            }
        }
        None
    }

    fn exec_sub(&mut self, content: String) {
        let parts: Vec<&str> = content.split_whitespace().collect();
        let dest = parts[1].replace(",", "");
        let src = parts[2].replace(",", "");
        let val_or_reg = parts[3].replace(",", "");
        let sub_value: u32;
        if let Some(value_str) = val_or_reg.strip_prefix('#') {
            let value_str = value_str.replace("#", "");
            sub_value = value_str.parse().expect("literal");
        } else {
            let value_str = val_or_reg.replace("r", "");
            let this_reg: usize = value_str.parse().expect("Failed to parse register index");
            sub_value = self.memory.get_reg(this_reg);
        }

        let src_val: u32;
        if let Some(src_str) = src.strip_prefix('r') {
            let src_register = src_str
                .replace("r", "")
                .parse()
                .expect("Unable to parse register");
            src_val = self.memory.get_reg(src_register);
        } else {
            src_val = self.memory.get_sp() as u32;
        }

        if let Some(dst_str) = dest.strip_prefix('r') {
            let dst_register = dst_str
                .replace("r", "")
                .parse()
                .expect("Unable to parse register");
            let dst_val = self.memory.get_reg(dst_register);
        } else if src == "sp" {
            self.memory.set_sp((src_val - sub_value) as usize);
        }
    }

    fn exec_str(&mut self, content: String) {
        if self.debug {
            println!("Executing str instruction: {}", content);
        }
        let parts: Vec<&str> = content.split_whitespace().collect();
        let dest_reg = parts[1].replace(",", "");
        let dest_idx: usize = dest_reg[1..]
            .parse()
            .expect("Failed to parse register index");
        let value = self.memory.get_reg(dest_idx);

        let addr_part = parts[2];
        let addr_part = addr_part.replace("[", "").replace("]", "");

        let mut base_addr: usize = 0;
        let mut offset: i32 = 0;
        let mut base_reg_name = String::new();

        for part in addr_part.split(",") {
            let part = part.trim();
            if part.starts_with("r") {
                base_reg_name = part.to_string();
            } else if part == "sp" {
                base_reg_name = "sp".to_string();
            } else if part.starts_with("#") {
                offset = part
                    .replace("#", "")
                    .parse()
                    .expect("Failed to parse offset");
            }
        }

        if base_reg_name == "sp" {
            base_addr = self.memory.get_sp();
        } else if base_reg_name.starts_with("r") {
            let reg_idx: usize = base_reg_name[1..]
                .parse()
                .expect("Failed to parse register index");
            base_addr = self.memory.get_reg(reg_idx) as usize;
        }

        let offset_from_sp = (base_addr as i32 - self.memory.get_sp() as i32 + offset) as usize;
        self.memory.write_stack32(offset_from_sp, value);

        if self.debug {
            println!("Stored value {} at stack offset {}", value, offset_from_sp);
            let stack_data = self.memory.get_stack();
            let sp = self.memory.get_sp();
            println!(
                "  SP: {:>10}, stack[SP]: {:02x} {:02x} {:02x} {:02x} = {}",
                sp,
                stack_data[sp],
                stack_data[sp + 1],
                stack_data[sp + 2],
                stack_data[sp + 3],
                u32::from_le_bytes([
                    stack_data[sp],
                    stack_data[sp + 1],
                    stack_data[sp + 2],
                    stack_data[sp + 3]
                ])
            );
        }
    }

    fn exec_ldr(&mut self, content: String) {
        if self.debug {
            println!("Executing ldr instruction: {}", content);
        }

        // 1. Parse the parts (e.g., "ldr", "r0,", "[sp, #0]")
        let parts: Vec<&str> = content.split_whitespace().collect();

        // 2. Identify the destination register (e.g., "r0")
        let dest_reg = parts[1].replace(",", "");
        let dest_idx: usize = dest_reg[1..]
            .parse()
            .expect("Failed to parse destination register index");

        // 3. Clean up the address part (e.g., "[sp, #0]" -> "sp, #0")
        let addr_part = parts[2].replace("[", "").replace("]", "");

        let mut base_addr: usize = 0;
        let mut offset: i32 = 0;
        let mut base_reg_name = String::new();

        // 4. Parse the base register and the offset
        for part in addr_part.split(",") {
            let part = part.trim();
            if part.starts_with("r") || part == "sp" {
                base_reg_name = part.to_string();
            } else if part.starts_with("#") {
                offset = part
                    .replace("#", "")
                    .parse()
                    .expect("Failed to parse offset");
            }
        }

        // 5. Calculate the actual base address from the register
        if base_reg_name == "sp" {
            base_addr = self.memory.get_sp();
        } else if base_reg_name.starts_with("r") {
            let reg_idx: usize = base_reg_name[1..]
                .parse()
                .expect("Failed to parse base register index");
            base_addr = self.memory.get_reg(reg_idx) as usize;
        }

        // 6. Calculate the effective offset relative to the stack start
        // Note: This logic assumes your memory model treats stack offsets relative to SP
        let effective_offset = (base_addr as i32 - self.memory.get_sp() as i32 + offset) as usize;

        // 7. Load the value from memory and update the register
        let value = self.memory.read_stack32(effective_offset);
        self.memory.set_reg(dest_idx, value);

        if self.debug {
            println!(
                "Loaded value {} from stack offset {} into r{}",
                value, effective_offset, dest_idx
            );
        }
    }

    fn exec_cmp(&self, content: String) {
        //NOTE: We need to implement Z, N,  C, V Flags for this
    }

    pub fn execute(&mut self) -> u32 {
        let branches = self.get_asm_branches();

        if !branches.contains_key("_start") {
            panic!("_start label not found");
        }

        let start_block = branches.get("_start").unwrap();

        for content in start_block.iter() {
            if self.debug {
                println!("RUNNING {content}");
            }
            match content.split_whitespace().next() {
                Some("mov") => {
                    self.exec_mov(content.clone());
                }
                Some("svc") => {
                    if let Some(exit_code) = self.exec_svc(content.clone()) {
                        return exit_code;
                    }
                }
                Some("sub") => {
                    self.exec_sub(content.clone());
                }
                Some("str") => {
                    self.exec_str(content.clone());
                }
                Some("ldr") => {
                    self.exec_ldr(content.clone());
                }
                Some(other) => {
                    println!("Instruction not implemented!: {}", other);
                }
                None => {
                    panic!("Empty line encountered");
                }
            }
        }
        0
    }
}

impl Default for Interpreter {
    fn default() -> Self {
        Self::new()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn create_interpreter() -> Interpreter {
        Interpreter::new()
    }

    #[test]
    fn test_mov_immediate() {
        let mut interp = create_interpreter();
        interp.exec_mov("mov r0, #42".to_string());
        assert_eq!(interp.memory.get_reg(0), 42);
    }

    #[test]
    fn test_mov_register_to_register() {
        let mut interp = create_interpreter();
        interp.memory.set_reg(1, 99);
        interp.exec_mov("mov r0, r1".to_string());
        assert_eq!(interp.memory.get_reg(0), 99);
    }

    #[test]
    fn test_mov_zero() {
        let mut interp = create_interpreter();
        interp.memory.set_reg(0, 42);
        interp.exec_mov("mov r0, #0".to_string());
        assert_eq!(interp.memory.get_reg(0), 0);
    }

    #[test]
    fn test_sub_sp() {
        let mut interp = create_interpreter();
        let initial_sp = interp.memory.get_sp();
        interp.exec_sub("sub sp, sp, #4".to_string());
        assert_eq!(interp.memory.get_sp(), initial_sp - 4);
    }

    #[test]
    fn test_sub_with_register() {
        let mut interp = create_interpreter();
        interp.memory.set_reg(1, 8);
        let initial_sp = interp.memory.get_sp();
        interp.exec_sub("sub sp, sp, r1".to_string());
        assert_eq!(interp.memory.get_sp(), initial_sp - 8);
    }

    #[test]
    fn test_str_store_to_stack() {
        let mut interp = create_interpreter();
        interp.memory.set_reg(0, 42);
        let initial_sp = interp.memory.get_sp();
        interp.memory.set_sp(initial_sp - 4);

        interp.exec_str("str r0, [sp]".to_string());

        let value = interp.memory.read_stack32(0);
        assert_eq!(value, 42);
    }

    #[test]
    fn test_ldr_load_from_stack() {
        let mut interp = create_interpreter();
        let initial_sp = interp.memory.get_sp();
        interp.memory.set_sp(initial_sp - 4);
        interp.memory.write_stack32(0, 123);

        interp.exec_ldr("ldr r0, [sp]".to_string());

        assert_eq!(interp.memory.get_reg(0), 123);
    }

    #[test]
    fn test_svc_exit_with_code() {
        let mut interp = create_interpreter();
        interp.memory.set_reg(7, 1);
        interp.memory.set_reg(0, 42);

        let result = interp.exec_svc("svc #0".to_string());

        assert_eq!(result, Some(42));
    }

    #[test]
    fn test_svc_ignores_other_syscalls() {
        let mut interp = create_interpreter();
        interp.memory.set_reg(7, 2);

        let result = interp.exec_svc("svc #0".to_string());

        assert_eq!(result, None);
    }

    #[test]
    fn test_get_asm_branches_single_function() {
        let mut interp = create_interpreter();
        interp.file = vec![
            "_start:".to_string(),
            "    mov r0, #1".to_string(),
            "    svc #0".to_string(),
        ];

        let branches = interp.get_asm_branches();

        assert!(branches.contains_key("_start"));
        assert_eq!(branches["_start"].len(), 2);
    }

    #[test]
    fn test_get_asm_branches_multiple_functions() {
        let mut interp = create_interpreter();
        interp.file = vec![
            "_start:".to_string(),
            "    mov r0, #1".to_string(),
            "    b else_block".to_string(),
            "else_block:".to_string(),
            "    mov r0, #2".to_string(),
            "    svc #0".to_string(),
        ];

        let branches = interp.get_asm_branches();

        assert!(branches.contains_key("_start"));
        assert!(branches.contains_key("else_block"));
    }

    #[test]
    fn test_execute_simple_program() {
        let mut interp = create_interpreter();
        interp.file = vec![
            "_start:".to_string(),
            "    mov r0, #10".to_string(),
            "    mov r7, #1".to_string(),
            "    svc #0".to_string(),
        ];

        let exit_code = interp.execute();

        assert_eq!(exit_code, 10);
    }

    #[test]
    fn test_execute_with_stack_operations() {
        let mut interp = create_interpreter();
        interp.file = vec![
            "_start:".to_string(),
            "    sub sp, sp, #4".to_string(),
            "    mov r0, #42".to_string(),
            "    str r0, [sp]".to_string(),
            "    ldr r1, [sp]".to_string(),
            "    mov r0, r1".to_string(),
            "    mov r7, #1".to_string(),
            "    svc #0".to_string(),
        ];

        let exit_code = interp.execute();

        assert_eq!(exit_code, 42);
    }
}
