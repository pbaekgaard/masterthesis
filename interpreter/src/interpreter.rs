use std::{fs::File, io::BufRead};

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
            debug: cfg!(debug_assertions),
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
        println!("╔══════════════════════════════════════════════════════════════════╗");
        println!("║                        MEMORY STATE                              ║");
        println!("╠══════════════════════════════════════════════════════════════════╣");

        println!("║ REGISTERS:                                                       ║");
        println!("╟──────────────────────────────────────────────────────────────────╢");
        for (i, &value) in self.memory.get_registers().iter().enumerate() {
            if i % 4 == 0 {
                print!("║ ");
            }
            print!("r{:2}: {:>10} ", i, value);
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

        println!("╚══════════════════════════════════════════════════════════════════╝");
    }

    pub fn shout_file(self) {
        println!("------------------- SHOUT FILE START -------------------");
        for (idx, line_content) in self.file.iter().enumerate() {
            println!("Line {idx}, Content: {line_content}");
        }
        println!("-------------------- SHOUT FILE END --------------------");
    }

    fn get_start(&self) -> Result<usize, String> {
        for (idx, content) in self.file.iter().enumerate() {
            if content.contains("_start:") {
                return Ok(idx);
            }
        }
        Err("_start label not found".to_string())
    }

    fn get_start_block(&self) -> Vec<String> {
        let start = match self.get_start() {
            Ok(start) => start,
            _ => panic!("ERROR IN GETTING START BLOCK"),
        };
        let mut res: Vec<String> = Vec::new();
        res.push(self.file.get(start).unwrap().clone());
        for i in start..self.file.len() {
            let content = self.file.get(i).unwrap();
            if content.starts_with("    ") {
                res.push(content.clone());
            }
        }
        res
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

    pub fn execute(&mut self) -> u32 {
        let start_block = self.get_start_block();
        for (i, content) in start_block.into_iter().enumerate() {
            if i == 0 {
                if self.debug {
                    println!("RUNNING {content}");
                }
                continue;
            }
            match content.split_whitespace().next() {
                Some("mov") => {
                    self.exec_mov(content);
                }
                Some("svc") => {
                    if let Some(exit_code) = self.exec_svc(content) {
                        return exit_code;
                    }
                }
                Some("sub") => {
                    let mut sp = self.memory.get_sp();
                    println!("StackPointer = {sp}");
                    self.exec_sub(content);
                    sp = self.memory.get_sp();
                    println!("StackPointer = {sp}");
                }
                Some(other) => {
                    panic!("Unknown instruction: {}", other);
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
