use std::collections::HashMap;
use std::fs::File;
use std::io::BufRead;

use crate::memory::EmulatorMemory;

const NUM_REGISTERS: usize = 32;

#[derive(Clone, Debug, PartialEq, Default)]
pub struct ItState {
    pub is_active: bool,
    pub base_cond: String,
    pub mask: Vec<char>,
    pub current_instr: usize,
}

#[derive(Clone, Debug, PartialEq, Default)]
pub struct Cpsr {
    pub n: bool,
    pub z: bool,
    pub c: bool,
    pub v: bool,
    pub it_state: ItState,
}
impl Cpsr {
    pub fn evaluate_condition(&self, cond: &str) -> bool {
        match cond.to_uppercase().as_str() {
            "EQ" => self.z,
            "NE" => !self.z,
            "HS" | "CS" => self.c,
            "LO" | "CC" => !self.c,
            "MI" => self.n,
            "PL" => !self.n,
            "VS" => self.v,
            "VC" => !self.v,
            "HI" => self.c && !self.z,
            "LS" => !self.c || self.z,
            "GE" => self.n == self.v,
            "LT" => self.n != self.v,
            "GT" => !self.z && self.n == self.v,
            "LE" => self.z || self.n != self.v,
            "AL" => true,
            _ => true, // Default to true if unknown
        }
    }
    pub fn should_execute(&mut self) -> bool {
        if !self.it_state.is_active {
            return true;
        }

        let step_idx = self.it_state.current_instr;
        let is_then = self.it_state.mask[step_idx] == 't';
        let condition_met = self.evaluate_condition(&self.it_state.base_cond);

        let execute = if is_then { condition_met } else { !condition_met };

        // Advance or Reset
        self.it_state.current_instr += 1;
        if self.it_state.current_instr >= self.it_state.mask.len() {
            self.it_state.is_active = false;
            self.it_state.mask.clear();
        }

        execute
    }
}

pub struct Interpreter {
    memory: EmulatorMemory,
    registers: [u32; NUM_REGISTERS],
    pc: u32,
    branch_map: HashMap<String, u32>,
    eof_pc: u32,
    cpsr: Cpsr,
    file: Vec<String>,
    debug: bool,
}

impl Interpreter {
    pub fn new() -> Self {
        Self {
            memory: EmulatorMemory::new(),
            registers: [0; NUM_REGISTERS],
            pc: 0,
            branch_map: HashMap::new(),
            eof_pc: 0,
            cpsr: Cpsr::default(),
            file: Vec::new(),
            debug: false,
        }
    }

    pub fn set_debug(&mut self, debug: bool) {
        self.debug = debug;
    }

    pub fn set_branch_map(&mut self, map: HashMap<String, u32>) {
        self.branch_map = map;
    }

    pub fn get_reg(&self, index: usize) -> u32 {
        self.registers[index]
    }

    pub fn set_reg(&mut self, index: usize, value: u32) {
        self.registers[index] = value;
    }

    pub fn get_pc(&self) -> u32 {
        self.pc
    }

    pub fn set_pc(&mut self, pc: u32) {
        self.pc = pc;
    }

    pub fn set_eof_pc(&mut self, pc: u32) {
        self.eof_pc = pc;
    }
    pub fn read_file(&mut self, file_path: &String) -> bool {
        let file = File::open(file_path).expect("Could not open file: {file_path}");
        let lines: Vec<String> = std::io::BufReader
            ::new(file)
            .lines()
            .map(|line| line.expect("Could not read line from file"))
            .collect();
        self.file = lines;
        true
    }

    pub fn print_registers(&self) {
        if self.debug {
            for (i, &value) in self.registers.iter().enumerate() {
                println!("r{}: {}", i, value);
            }
        }
    }

    pub fn get_registers(&self) -> &[u32; NUM_REGISTERS] {
        &self.registers
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
        for (i, &value) in self.registers.iter().enumerate() {
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
        println!("║ CPSR FLAGS:                                                      ║");
        println!("╟──────────────────────────────────────────────────────────────────╢");
        println!("║   Z (Zero):     {:<5}                                          ║", self.cpsr.z);
        println!("║   N (Negative): {:<5}                                          ║", self.cpsr.n);
        println!("║   C (Carry):    {:<5}                                          ║", self.cpsr.c);
        println!("║   V (Overflow): {:<5}                                          ║", self.cpsr.v);

        println!("╟──────────────────────────────────────────────────────────────────╢");
        println!("║ PROGRAM COUNTER:                                                 ║");
        println!(
            "║   PC: {:>10} (0x{:08x})                                    ║",
            self.pc,
            self.pc
        );

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
                    if (32..127).contains(&byte) {
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
                    if (32..127).contains(&byte) {
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

    fn get_start(&mut self) -> Vec<String> {
        let mut result = Vec::new();
        let mut branch_map: HashMap<String, u32> = HashMap::new();
        let mut found_start = false;

        for line in &self.file {
            match line.starts_with("_start:") {
                true => {
                    found_start = true;
                    let label = line.trim_start().to_string();
                    result.push(label.clone());
                    branch_map.insert(
                        label[0..label.len() - 1].to_string(),
                        (result.len() - 1) as u32
                    );
                }
                false => {
                    if found_start {
                        if line.starts_with(".size _start") {
                            result.pop();
                        } else {
                            let label = line.trim_start().to_string();
                            result.push(line.trim_start().to_string());
                            if line.contains(":") {
                                branch_map.insert(
                                    label[0..label.len() - 1].to_string(),
                                    (result.len() - 1) as u32
                                );
                            }
                        }
                    }
                }
            }
        }
        for (k, v) in branch_map.clone() {
            println!("label: {k}, pc: {v}");
        }

        self.set_eof_pc(result.len() as u32);
        self.set_branch_map(branch_map);
        result
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
            self.set_reg(dest_idx, value);
            if self.debug {
                println!("Mock: mov r{}, #{} (stored in register)", dest_idx, value);
            }
        } else {
            let src_idx: usize = src[1..].parse().expect("Failed to parse register index");
            value = self.get_reg(src_idx);
            self.set_reg(dest_idx, value);
            if self.debug {
                println!("Mock: mov r{}, r{} (register to register)", dest_idx, src_idx);
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
                let syscall_num = self.get_reg(7);
                if syscall_num == 1 {
                    let exit_code = self.get_reg(0);
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
            sub_value = self.get_reg(this_reg);
        }

        let src_val: u32;
        if let Some(src_str) = src.strip_prefix('r') {
            let src_register = src_str.replace("r", "").parse().expect("Unable to parse register");
            src_val = self.get_reg(src_register);
        } else {
            src_val = self.memory.get_sp() as u32;
        }

        if let Some(dst_str) = dest.strip_prefix('r') {
            let dst_register = dst_str.replace("r", "").parse().expect("Unable to parse register");
            let dst_val = self.get_reg(dst_register);
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
        let dest_idx: usize = dest_reg[1..].parse().expect("Failed to parse register index");
        let value = self.get_reg(dest_idx);

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
                offset = part.replace("#", "").parse().expect("Failed to parse offset");
            }
        }

        if base_reg_name == "sp" {
            base_addr = self.memory.get_sp();
        } else if base_reg_name.starts_with("r") {
            let reg_idx: usize = base_reg_name[1..]
                .parse()
                .expect("Failed to parse register index");
            base_addr = self.get_reg(reg_idx) as usize;
        }

        let offset_from_sp = ((base_addr as i32) - (self.memory.get_sp() as i32) + offset) as usize;
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
                    stack_data[sp + 3],
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
                offset = part.replace("#", "").parse().expect("Failed to parse offset");
            }
        }

        // 5. Calculate the actual base address from the register
        if base_reg_name == "sp" {
            base_addr = self.memory.get_sp();
        } else if base_reg_name.starts_with("r") {
            let reg_idx: usize = base_reg_name[1..]
                .parse()
                .expect("Failed to parse base register index");
            base_addr = self.get_reg(reg_idx) as usize;
        }

        // 6. Calculate the effective offset relative to the stack start
        // Note: This logic assumes your memory model treats stack offsets relative to SP
        let effective_offset = ((base_addr as i32) -
            (self.memory.get_sp() as i32) +
            offset) as usize;

        // 7. Load the value from memory and update the register
        let value = self.memory.read_stack32(effective_offset);
        self.set_reg(dest_idx, value);

        if self.debug {
            println!(
                "Loaded value {} from stack offset {} into r{}",
                value,
                effective_offset,
                dest_idx
            );
        }
    }

    fn exec_cmp(&mut self, content: String) {
        if self.debug {
            println!("Executing cmp instruction: {}", content);
        }

        let parts: Vec<&str> = content
            .split(|c: char| (c == ',' || c.is_whitespace()))
            .filter(|s| !s.is_empty())
            .collect();

        if parts.len() < 3 {
            return;
        }

        let rn_idx: usize = parts[1][1..].parse().expect("Failed to parse Rn index");
        let val_n = self.get_reg(rn_idx);

        let val_op2 = if let Some(imm_str) = parts[2].strip_prefix('#') {
            imm_str.parse::<u32>().expect("Failed to parse immediate")
        } else {
            let rm_idx: usize = parts[2][1..].parse().expect("Failed to parse Rm index");
            self.get_reg(rm_idx)
        };
        let res_u64 = (val_n as u64).wrapping_sub(val_op2 as u64);
        let result = res_u64 as u32;

        self.cpsr.z = result == 0;
        self.cpsr.n = (result >> 31) == 1;
        self.cpsr.c = val_n >= val_op2;

        let rn_i = val_n as i32;
        let op2_i = val_op2 as i32;
        let (_, overflow) = rn_i.overflowing_sub(op2_i);
        self.cpsr.v = overflow;

        if self.debug {
            println!(
                "CMP Result: {:#x} - {:#x} = {:#x} | Flags: N:{} Z:{} C:{} V:{}",
                val_n,
                val_op2,
                result,
                self.cpsr.n,
                self.cpsr.z,
                self.cpsr.c,
                self.cpsr.v
            );
        }
    }

    fn exec_itx(&mut self, content: String) {
        let parts: Vec<&str> = content.split_whitespace().collect();
        let mnemonic = parts[0].to_lowercase(); // e.g., "itete"
        let cond = parts[1].to_uppercase(); // e.g., "GT"

        self.cpsr.it_state.is_active = true;
        self.cpsr.it_state.base_cond = cond;
        self.cpsr.it_state.current_instr = 0;

        // Convert "itete" into ['T', 'E', 'T', 'E']
        self.cpsr.it_state.mask = mnemonic.chars().skip(1).collect();
    }

    //NOTE: Maybe we could just use one single exec_b, and have it check if the instruction is beq
    //or ble etc. and use the cpsr register to do stuff instead of a million branch function for
    //each conditional version
    fn exec_b(&mut self, content: String) {
        // trim instruction to branch or branch + condition
        let parts: Vec<&str> = content.split_whitespace().collect();
        if parts[0].len() > 1 {
            let cond = &parts[0][1..];
            let is_cond = self.cpsr.evaluate_condition(cond);
            if is_cond {
                self.set_pc(self.branch_map.get(parts[1]).unwrap().clone());
            } else {
                return;
            }
        } else {
            self.set_pc(self.branch_map.get(parts[1]).unwrap().clone());
        }
    }

    fn exec_add(&mut self, content: String) {
        let parts: Vec<&str> = content.split_whitespace().collect();

        let dest = parts[1].replace(",", "");
        let op1 = parts[2].replace(",", "");
        let op2 = parts[3].replace(",", "");

        let dest_idx: usize = if dest == "sp" { 13 } else { dest[1..].parse().unwrap() };

        let src_val: u32 = if op1 == "sp" {
            self.memory.get_sp() as u32
        } else {
            let src_idx: usize = op1[1..].parse().unwrap();
            self.get_reg(src_idx)
        };

        let value = if let Some(imm) = op2.strip_prefix('#') {
            imm.parse::<u32>().unwrap()
        } else {
            let reg_idx: usize = if op2 == "sp" { 13 } else { op2[1..].parse().unwrap() };
            self.get_reg(reg_idx)
        };

        let result = src_val.wrapping_add(value);

        if dest == "sp" {
            self.memory.set_sp(result as usize);
        } else {
            self.set_reg(dest_idx, result);
        }
    }

    pub fn execute(&mut self) -> u32 {
        let start_block = self.get_start();
        while self.pc < self.eof_pc {
            let instruction = start_block.get(self.pc as usize).unwrap();
            let pc = self.pc;
            if !self.cpsr.should_execute() {
                if self.debug {
                    println!("   -> Condition not met, skipping.");
                }
                self.set_pc(self.pc + 1);
                continue; // Skip the match logic entirely
            }
            match instruction {
                f if f.starts_with("mov") => self.exec_mov(instruction.clone()),
                f if f.starts_with("svc") => {
                    if let Some(exit_code) = self.exec_svc(instruction.clone()) {
                        return exit_code;
                    }
                }
                f if f.starts_with("sub") => self.exec_sub(instruction.clone()),
                f if f.starts_with("str") => self.exec_str(instruction.clone()),
                f if f.starts_with("ldr") => self.exec_ldr(instruction.clone()),
                f if f.starts_with("cmp") => self.exec_cmp(instruction.clone()),
                f if f.starts_with("it") => self.exec_itx(instruction.clone()),
                f if f.starts_with("b") => self.exec_b(instruction.clone()),
                f if f.starts_with("add") => self.exec_add(instruction.clone()),
                f if f.contains(":") => {
                    self.set_pc(self.pc + 1);
                    continue;
                }
                Invalid => panic!("Invalid instruction: {Invalid}"),
            }
            self.set_pc(self.pc + 1);
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
    use std::fs;
    use std::path::Path;
    use std::process::Command;

    fn run_qemu(asm_path: &str) -> i32 {
        let path = Path::new(asm_path);
        let stem = path.file_stem().unwrap().to_str().unwrap();

        let obj = format!("/tmp/{}.o", stem);
        let bin = format!("/tmp/{}", stem);

        // Assemble
        let status = Command::new("arm-none-eabi-as")
            .args(["-mthumb", "-o", &obj, asm_path])
            .status()
            .expect("Failed to run assembler");

        assert!(status.success(), "Assembler failed for {}", asm_path);

        // Link
        let status = Command::new("arm-none-eabi-ld")
            .args(["-o", &bin, &obj])
            .status()
            .expect("Failed to run linker");

        assert!(status.success(), "Linker failed for {}", asm_path);

        // Run in qemu
        let status = Command::new("qemu-arm").arg(&bin).status().expect("Failed to run qemu");

        status.code().unwrap_or(-1)
    }

    #[test]
    fn test_qemu_vs_interpreter() {
        let test_dir = Path::new("test_codes_compiled");

        for entry in fs::read_dir(test_dir).expect("Failed to read test directory") {
            let entry = entry.unwrap();
            let path = entry.path();

            if path.extension().and_then(|s| s.to_str()) != Some("asm") {
                continue;
            }

            let file_path = path.to_str().unwrap();

            println!("Testing file: {}", file_path);

            // Run qemu
            let qemu_exit = run_qemu(file_path);
            // Run interpreter
            let mut interp = Interpreter::new();
            interp.read_file(&file_path.to_string());
            let interp_exit = interp.execute();
            println!("file executed");

            println!("Result -> qemu: {}, interpreter: {}", qemu_exit, interp_exit);

            assert_eq!(qemu_exit as u32, interp_exit, "Mismatch for {}", file_path);
        }
    }
    #[test]
    fn test_mov_immediate() {
        let mut interp = create_interpreter();
        interp.exec_mov("mov r0, #42".to_string());
        assert_eq!(interp.get_reg(0), 42);
    }

    #[test]
    fn test_mov_register_to_register() {
        let mut interp = create_interpreter();
        interp.set_reg(1, 99);
        interp.exec_mov("mov r0, r1".to_string());
        assert_eq!(interp.get_reg(0), 99);
    }

    #[test]
    fn test_mov_zero() {
        let mut interp = create_interpreter();
        interp.set_reg(0, 42);
        interp.exec_mov("mov r0, #0".to_string());
        assert_eq!(interp.get_reg(0), 0);
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
        interp.set_reg(1, 8);
        let initial_sp = interp.memory.get_sp();
        interp.exec_sub("sub sp, sp, r1".to_string());
        assert_eq!(interp.memory.get_sp(), initial_sp - 8);
    }

    #[test]
    fn test_str_store_to_stack() {
        let mut interp = create_interpreter();
        interp.set_reg(0, 42);
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

        assert_eq!(interp.get_reg(0), 123);
    }

    #[test]
    fn test_svc_exit_with_code() {
        let mut interp = create_interpreter();
        interp.set_reg(7, 1);
        interp.set_reg(0, 42);

        let result = interp.exec_svc("svc #0".to_string());

        assert_eq!(result, Some(42));
    }

    #[test]
    fn test_svc_ignores_other_syscalls() {
        let mut interp = create_interpreter();
        interp.set_reg(7, 2);

        let result = interp.exec_svc("svc #0".to_string());

        assert_eq!(result, None);
    }

    #[test]
    fn test_get_start_single_function() {
        let mut interp = create_interpreter();
        interp.file = vec![
            "_start:".to_string(),
            "    mov r0, #1".to_string(),
            "    svc #0".to_string()
        ];

        let start_block = interp.get_start();
        let test_label = "_start:".to_string();
        assert!(start_block.contains(&test_label));
        assert_eq!(start_block.len(), 3);
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
            "    svc #0".to_string()
        ];

        let start_block = interp.get_start();
        
        assert!(start_block.contains(&"_start".to_string()));
        assert!(start_block.contains(&"else_block".to_string()));
    }

    #[test]
    fn test_execute_simple_program() {
        let mut interp = create_interpreter();
        interp.file = vec![
            "_start:".to_string(),
            "    mov r0, #10".to_string(),
            "    mov r7, #1".to_string(),
            "    svc #0".to_string()
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
            "    svc #0".to_string()
        ];

        let exit_code = interp.execute();

        assert_eq!(exit_code, 42);
    }

    #[test]
    fn test_cmp_logic() {
        let mut interp = create_interpreter();

        // 1. Test Equality (Z flag)
        interp.set_reg(1, 100);
        interp.exec_cmp("cmp r1, #100".to_string());
        assert!(interp.cpsr.z, "Z should be true when values are equal");
        assert!(!interp.cpsr.n, "N should be false when values are equal");
        assert!(interp.cpsr.c, "C should be true (no borrow) when equal");

        // 2. Test Less Than (N flag)
        interp.set_reg(1, 50);
        interp.exec_cmp("cmp r1, #100".to_string());
        assert!(!interp.cpsr.z, "Z should be false when not equal");
        assert!(interp.cpsr.n, "N should be true because 50 - 100 is negative");
        assert!(!interp.cpsr.c, "C should be false because 50 < 100 (borrow occurred)");

        // 3. Test Greater Than (Positive result)
        interp.set_reg(1, 200);
        interp.exec_cmp("cmp r1, #100".to_string());
        assert!(!interp.cpsr.z);
        assert!(!interp.cpsr.n);
        assert!(interp.cpsr.c, "C should be true because 200 >= 100");

        // 4. Test Signed Overflow (V flag)
        // Large positive minus a large negative results in a value
        // too big for 32-bit signed integer (wraps around)
        interp.set_reg(1, 0x7fffffff); // Max Positive i32
        interp.set_reg(2, 0xffffffff); // -1 in two's complement
        // Math: 0x7FFFFFFF - (-1) = 0x80000000 (which is -2147483648 in signed)
        interp.exec_cmp("cmp r1, r2".to_string());
        assert!(interp.cpsr.v, "V should be true due to signed overflow");
        assert!(interp.cpsr.n, "N should be true because result wrapped to 0x80000000");
    }
    #[test]
    fn test_it_block_execution_logic() {
        let mut interp = create_interpreter();

        // 1. Setup the IT block: ITE GT (3 instructions total)
        // First 'T' = GT, second 'E' = LE (Not GT), third 'E' = LE
        interp.exec_itx("iteee gt".to_string());

        assert!(interp.cpsr.it_state.is_active);
        assert_eq!(interp.cpsr.it_state.base_cond, "GT");
        assert_eq!(interp.cpsr.it_state.mask, vec!['t', 'e', 'e', 'e']);

        // 2. Scenario A: Condition is TRUE (R1 > R0)
        interp.set_reg(1, 100);
        interp.set_reg(0, 50);
        interp.exec_cmp("cmp r1, r0".to_string()); // Sets flags for GT

        // We expect: Step 0 (T) -> Execute, Step 1 (E) -> Skip
        assert!(interp.cpsr.evaluate_condition("GT"), "GT should be true");

        // Test Instruction 1 (T)
        let should_run_1 = interp.cpsr.should_execute();
        assert!(should_run_1, "Instruction 1 (T) should run when GT is true");
        assert_eq!(interp.cpsr.it_state.current_instr, 1);

        // Test Instruction 2 (E)
        let should_run_2 = interp.cpsr.should_execute();
        assert!(!should_run_2, "Instruction 2 (E) should NOT run when GT is true");
        assert_eq!(interp.cpsr.it_state.current_instr, 2);

        // 3. Reset and Scenario B: Condition is FALSE (R1 < R0)
        interp.exec_itx("ite gt".to_string()); // 2 instructions
        interp.set_reg(1, 10);
        interp.set_reg(0, 50);
        interp.exec_cmp("cmp r1, r0".to_string()); // Sets flags for LT (Not GT)

        assert!(!interp.cpsr.evaluate_condition("GT"), "GT should be false");

        // Test Instruction 1 (T)
        let should_run_1_f = interp.cpsr.should_execute();
        assert!(!should_run_1_f, "Instruction 1 (T) should NOT run when GT is false");

        // Test Instruction 2 (E)
        let should_run_2_f = interp.cpsr.should_execute();
        assert!(should_run_2_f, "Instruction 2 (E) SHOULD run when GT is false (Else case)");

        // Verify block auto-deactivates
        assert!(
            !interp.cpsr.it_state.is_active,
            "IT block should be inactive after last instruction"
        );
    }
}
