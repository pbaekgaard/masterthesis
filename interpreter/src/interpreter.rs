use std::collections::HashMap;
use std::fs::File;
use std::io::BufRead;
use std::process::exit;
use std::usize;

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

pub enum InjectionTarget {
    Register {
        register: usize,
        bit: u32,
    },
    Memory {
        address: u32,
        bit: u32,
    },
    ProgramCounter {
        bit: u32,
    },
    Cpsr {
        register: usize,
        bit: u32,
    },
    None,
}

pub struct InjectionSpec {
    pub target: InjectionTarget,
    pub trigger_pc: i32,
}

pub struct Interpreter {
    memory: EmulatorMemory,
    registers: [i32; NUM_REGISTERS],
    pc: u32,
    eof_pc: u32,
    branch_map: HashMap<String, u32>,
    data_map: HashMap<String, usize>,
    cpsr: Cpsr,
    file: Vec<String>,
    debug: bool,
    start_time: std::time::Instant,
    max_time: std::time::Duration,
    fault_spec: InjectionSpec,
}

impl Interpreter {
    pub fn new() -> Self {
        Self {
            memory: EmulatorMemory::new(),
            registers: [0; NUM_REGISTERS],
            pc: 0,
            branch_map: HashMap::new(),
            data_map: HashMap::new(),
            eof_pc: 0,
            cpsr: Cpsr::default(),
            file: Vec::new(),
            debug: false,
            start_time: std::time::Instant::now(),
            max_time: std::time::Duration::from_millis(1000),
            fault_spec: InjectionSpec {
                target: InjectionTarget::None,
                trigger_pc: -1,
            },
        }
    }

    pub fn inject(&mut self, injection_point: String) {
        // FORMAT: X:Y:Z
        // X = PC
        // Y = Register
        // Z = Bit to flip
        let mut register: usize = usize::MAX;
        let mut parts = injection_point.split(':');

        // Get the first three parts
        let fault_type = parts.next().ok_or("Missing PC value").unwrap();
        let pc = parts.next().ok_or("Missing PC value").unwrap().parse::<i32>().unwrap();
        if fault_type == "reg" {
            register = parts
                .next()
                .ok_or("Missing Register value")
                .unwrap()
                .parse::<usize>()
                .unwrap();
        }
        let bit = parts.next().ok_or("Missing Bit value").unwrap().parse::<u32>().unwrap();

        // CRITICAL: Check if there is a 5th part
        if parts.next().is_some() {
            panic!("Correct format for injection point is \"Type:X:Y:Z\"");
        }
        if register == usize::MAX && fault_type == "reg" {
            panic!("Register is usize::MAX");
        }
        let injection_target = if fault_type == "reg" {
            InjectionTarget::Register { register, bit }
        } else {
            InjectionTarget::ProgramCounter { bit }
        };
        self.fault_spec.trigger_pc = pc;
        self.fault_spec.target = injection_target;
        if fault_type == "reg" {
            println!(
                "Setup Injection Specification:\n   Type: reg\n Trigger PC: {pc}\n  Register: {register}\n  Bit: {bit}"
            );
        } else {
            println!(
                "Setup Injection Specification:\n   Type: PC\n  Trigger PC: {pc}\n  Bit: {bit}"
            );
        }
    }

    pub fn set_debug(&mut self, debug: bool) {
        self.debug = debug;
    }

    pub fn set_max_time(&mut self, nanoseconds: u128) {
        self.max_time = std::time::Duration::from_nanos_u128(nanoseconds);
    }

    pub fn set_branch_map(&mut self, map: HashMap<String, u32>) {
        self.branch_map = map;
    }

    pub fn get_reg(&self, index: usize) -> i32 {
        self.registers[index]
    }

    pub fn set_reg(&mut self, index: usize, value: i32) {
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

    pub fn get_registers(&self) -> &[i32; NUM_REGISTERS] {
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
                            break;
                        } else if line.starts_with(".section .data") || line.starts_with(".data") {
                            break;
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

        self.set_eof_pc(result.len() as u32);
        self.set_branch_map(branch_map);
        result
    }

    fn parse_data_section(&mut self) {
        let mut in_data_section = false;
        let mut current_addr = 0;
        let mut last_label: Option<String> = None;

        for line in &self.file {
            let line = line.trim();

            if line.starts_with(".section .data") || line == ".data" {
                in_data_section = true;
                continue;
            }

            if line.starts_with(".text") || line.starts_with(".section .text") {
                in_data_section = false;
                continue;
            }

            if in_data_section {
                // A label definition line is of the form `label:` (colon at end).
                // Don't treat directives like `.ascii "a:b"` as a label just because
                // the string literal contains ':'.
                if line.ends_with(':') {
                    let label = line.trim_end_matches(':').to_string();
                    self.data_map.insert(label.clone(), current_addr);
                    last_label = Some(label);
                } else if line.contains(".ascii") {
                    if let Some(_) = line.find("\"") {
                        let start = line.find("\"").unwrap() + 1;
                        let end = start + line[start..].find("\"").unwrap();
                        let string_data = &line[start..end];

                        // The assembler interprets escapes inside ".ascii" strings (e.g., "\n").
                        // We store the resulting bytes into the emulated data/heap region.
                        let mut chars = string_data.chars().peekable();
                        while let Some(ch) = chars.next() {
                            if ch == '\\' {
                                let esc = chars.next().unwrap_or('\\');
                                let byte = match esc {
                                    'n' => b'\n',
                                    'r' => b'\r',
                                    't' => b'\t',
                                    '0' => b'\0',
                                    '\\' => b'\\',
                                    '"' => b'"',
                                    // Unknown escape: keep as-is (backslash + char)
                                    other => {
                                        self.memory.heap[current_addr] = b'\\';
                                        current_addr += 1;
                                        other as u8
                                    }
                                };
                                self.memory.heap[current_addr] = byte;
                                current_addr += 1;
                            } else {
                                self.memory.heap[current_addr] = ch as u8;
                                current_addr += 1;
                            }
                        }
                    }
                } else if line.contains(".space") {
                    if let Some(size_str) = line.split(".space").nth(1) {
                        let size: usize = size_str.trim().parse().unwrap_or(0);
                        for _ in 0..size {
                            self.memory.heap[current_addr] = 0;
                            current_addr += 1;
                        }
                    }
                }
            }
        }
    }

    fn exec_mov(&mut self, content: String) {
        if self.debug {
            println!("Executing mov instruction: {}", content);
        }
        let parts: Vec<&str> = content.split_whitespace().collect();
        let dest = parts[1].replace(",", "");
        let src = parts[2].replace(",", "");

        let dest_idx: usize = dest[1..].parse().expect("Failed to parse register index");

        if let Some(value_str) = src.strip_prefix('#') {
            let value: i32 = value_str.parse().expect("Failed to parse immediate value");
            self.set_reg(dest_idx, value);
            if self.debug {
                println!("Mock: mov r{}, #{} (stored in register)", dest_idx, value);
            }
        } else {
            let src_idx: usize = src[1..].parse().expect("Failed to parse register index");
            let value = self.get_reg(src_idx);
            self.set_reg(dest_idx, value);
            if self.debug {
                println!("Mock: mov r{}, r{} (register to register)", dest_idx, src_idx);
            }
        }
    }

    fn exec_svc(&mut self, content: String) -> Option<i32> {
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
                } else if syscall_num == 4 {
                    let fd = self.get_reg(0);
                    let addr = self.get_reg(1) as usize;
                    let len = self.get_reg(2) as usize;

                    if fd == 1 {
                        let data = self.memory.read_heap(addr, len);
                        print!("{}", String::from_utf8_lossy(&data));
                        use std::io::Write;
                        std::io::stdout().flush().ok();
                    }
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
        let sub_value: i32;
        if let Some(value_str) = val_or_reg.strip_prefix('#') {
            let value_str = value_str.replace("#", "");
            sub_value = value_str.parse().expect("literal");
        } else {
            let value_str = val_or_reg.replace("r", "");
            let this_reg: usize = value_str.parse().expect("Failed to parse register index");
            sub_value = self.get_reg(this_reg);
        }

        let src_val: i32;
        if let Some(src_str) = src.strip_prefix('r') {
            let src_register = src_str.replace("r", "").parse().expect("Unable to parse register");
            src_val = self.get_reg(src_register);
        } else {
            src_val = self.memory.get_sp() as i32;
        }

        if let Some(dst_str) = dest.strip_prefix('r') {
            let dst_register = dst_str.replace("r", "").parse().expect("Unable to parse register");
            let result = src_val - sub_value;
            self.set_reg(dst_register, result);
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

        let addr_part = content
            .split_once('[')
            .and_then(|(_, rest)| rest.split_once(']'))
            .map(|(inside, _)| inside)
            .unwrap_or("");

        let mut base_addr: usize = 0;
        let mut offset: i32 = 0;
        let mut base_reg_name = String::new();

        for part in addr_part.split(',') {
            let part = part.trim();
            if part == "sp" || part.starts_with('r') {
                base_reg_name = part.to_string();
            } else if let Some(imm) = part.strip_prefix('#') {
                offset = imm.parse().expect("Failed to parse offset");
            }
        }

        if base_reg_name == "sp" {
            base_addr = self.memory.get_sp();
        } else if let Some(reg_num) = base_reg_name.strip_prefix('r') {
            let reg_idx: usize = reg_num.parse().expect("Failed to parse register index");
            base_addr = self.get_reg(reg_idx) as usize;
        }

        let effective_addr = ((base_addr as i32) + offset) as usize;
        self.memory.write_stack32_at(effective_addr, value as u32);

        if self.debug {
            println!("Stored value {} at address {}", value, effective_addr);
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

        // Handle "ldr rN, =label" form (load address of label)
        if content.contains("=.") || content.contains("=num_buf") || content.contains("=newline") {
            let parts: Vec<&str> = content.split_whitespace().collect();
            let dest_reg = parts[1].replace(",", "");
            let dest_idx: usize = dest_reg[1..]
                .parse()
                .expect("Failed to parse destination register index");

            // Try to find the label
            let mut label_found = false;

            if let Some(label_start) = content.find("=.") {
                let label = &content[label_start + 1..];
                let label = label.trim().trim_end_matches('\n');
                if let Some(&addr) = self.data_map.get(label) {
                    self.set_reg(dest_idx, addr as i32);
                    label_found = true;
                    if self.debug {
                        println!("Loaded label address {} for {} into r{}", addr, label, dest_idx);
                    }
                }
            }

            if !label_found && content.contains("=num_buf") {
                if let Some(&addr) = self.data_map.get("num_buf") {
                    self.set_reg(dest_idx, addr as i32);
                    label_found = true;
                    if self.debug {
                        println!("Loaded label address {} for num_buf into r{}", addr, dest_idx);
                    }
                }
            }

            if !label_found && content.contains("=newline") {
                if let Some(&addr) = self.data_map.get("newline") {
                    self.set_reg(dest_idx, addr as i32);
                    if self.debug {
                        println!("Loaded label address {} for newline into r{}", addr, dest_idx);
                    }
                }
            }

            return;
        }

        // 1. Parse the parts (e.g., "ldr", "r0,", "[sp, #0]")
        let parts: Vec<&str> = content.split_whitespace().collect();

        // 2. Identify the destination register (e.g., "r0")
        let dest_reg = parts[1].replace(",", "");
        let dest_idx: usize = dest_reg[1..]
            .parse()
            .expect("Failed to parse destination register index");

        // 3. Extract the address contents between '[' and ']'
        // Handles forms like: [sp], [sp,#4], [sp, #4]
        let addr_part = content
            .split_once('[')
            .and_then(|(_, rest)| rest.split_once(']'))
            .map(|(inside, _)| inside)
            .unwrap_or("");

        let mut base_addr: usize = 0;
        let mut offset: i32 = 0;
        let mut base_reg_name = String::new();

        // 4. Parse the base register and optional immediate offset
        for part in addr_part.split(',') {
            let part = part.trim();
            if part == "sp" || part.starts_with('r') {
                base_reg_name = part.to_string();
            } else if let Some(imm) = part.strip_prefix('#') {
                offset = imm.parse().expect("Failed to parse offset");
            }
        }

        // 5. Calculate the actual base address from the register
        if base_reg_name == "sp" {
            base_addr = self.memory.get_sp();
        } else if let Some(reg_num) = base_reg_name.strip_prefix('r') {
            let reg_idx: usize = reg_num.parse().expect("Failed to parse base register index");
            base_addr = self.get_reg(reg_idx) as usize;
        }

        // 6. Calculate the effective address
        let effective_addr = ((base_addr as i32) + offset) as usize;

        // 7. Load the value from memory and update the register
        let value = self.memory.read_stack32_at(effective_addr);
        self.set_reg(dest_idx, value as i32);

        if self.debug {
            println!("Loaded value {} from address {} into r{}", value, effective_addr, dest_idx);
        }
    }

    fn exec_cmp(&mut self, content: String) {
        if self.debug {
            println!("Executing cmp instruction: {}", content);
        }
        let pc = self.pc;

        let parts: Vec<&str> = content
            .split(|c: char| (c == ',' || c.is_whitespace()))
            .filter(|s| !s.is_empty())
            .collect();

        if parts.len() < 3 {
            return;
        }

        let rn_idx: usize = parts[1][1..].parse().expect("Failed to Rn index");
        let val_n = self.get_reg(rn_idx);

        let val_op2 = if let Some(imm_str) = parts[2].strip_prefix('#') {
            imm_str.parse::<i32>().expect("Failed to parse immediate")
        } else {
            let rm_idx: usize = parts[2][1..].parse().expect("Failed to parse Rm index");
            self.get_reg(rm_idx)
        };
        let result = val_n.wrapping_sub(val_op2);

        self.cpsr.z = result == 0;
        self.cpsr.n = result < 0;
        self.cpsr.c = (val_n as u32) >= (val_op2 as u32);

        let (_, overflow) = val_n.overflowing_sub(val_op2);
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
                let branch_pc = self.branch_map.get(parts[1]).unwrap().clone();
                self.set_pc(branch_pc);
            } else {
                self.set_pc(self.get_pc() + 1);
                return;
            }
        } else {
            let branch_pc = self.branch_map.get(parts[1]).unwrap().clone();
            self.set_pc(branch_pc);
        }
    }

    fn exec_add(&mut self, content: String) {
        if self.debug {
            println!("Executing add instruction: {}", content);
        }
        let parts: Vec<&str> = content.split_whitespace().collect();

        let dest = parts[1].replace(",", "");
        let op1 = parts[2].replace(",", "");
        let op2 = parts[3].replace(",", "");

        let dest_idx: usize = if dest == "sp" { 13 } else { dest[1..].parse().unwrap() };

        let src_val: i32 = if op1 == "sp" {
            self.memory.get_sp() as i32
        } else {
            let src_idx: usize = op1[1..].parse().unwrap();
            self.get_reg(src_idx)
        };

        let value = if let Some(imm) = op2.strip_prefix('#') {
            imm.parse::<i32>().unwrap()
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

    fn exec_mul(&mut self, content: String) {
        let parts: Vec<&str> = content.split_whitespace().collect();

        let dest = parts[1].replace(",", "");
        let op1 = parts[2].replace(",", "");
        let op2 = parts[3].replace(",", "");

        let dest_idx: usize = dest[1..].parse().unwrap();

        let src_val: i32 = {
            let src_idx: usize = op1[1..].parse().unwrap();
            self.get_reg(src_idx)
        };

        let value: i32 = {
            let reg_idx: usize = op2[1..].parse().unwrap();
            self.get_reg(reg_idx)
        };

        let result = src_val.wrapping_mul(value);
        self.set_reg(dest_idx, result);
    }

    fn exec_sdiv(&mut self, content: String) {
        if self.debug {
            println!("Executing sdiv instruction: {}", content);
        }
        let parts: Vec<&str> = content.split_whitespace().collect();

        let dest = parts[1].replace(",", "");
        let op1 = parts[2].replace(",", "");
        let op2 = parts[3].replace(",", "");

        let dest_idx: usize = dest[1..].parse().unwrap();

        let src_val: i32 = {
            let src_idx: usize = op1[1..].parse().unwrap();
            self.get_reg(src_idx)
        };

        let value: i32 = {
            let reg_idx: usize = op2[1..].parse().unwrap();
            self.get_reg(reg_idx)
        };

        let result = src_val / value;
        self.set_reg(dest_idx, result);
    }

    fn exec_strb(&mut self, content: String) {
        if self.debug {
            println!("Executing strb instruction: {}", content);
        }
        let parts: Vec<&str> = content.split_whitespace().collect();
        let src_reg = parts[1].replace(",", "");
        let src_idx: usize = src_reg[1..].parse().expect("Failed to parse register index");
        let value = self.get_reg(src_idx) as u8;

        let addr_part = content
            .split_once('[')
            .and_then(|(_, rest)| rest.split_once(']'))
            .map(|(inside, _)| inside)
            .unwrap_or("");

        let mut base_addr: usize = 0;
        let mut offset: i32 = 0;
        let mut base_reg_name = String::new();

        for part in addr_part.split(',') {
            let part = part.trim();
            if part == "sp" || part.starts_with('r') {
                base_reg_name = part.to_string();
            } else if let Some(imm) = part.strip_prefix('#') {
                offset = imm.parse().expect("Failed to parse offset");
            }
        }

        if base_reg_name == "sp" {
            base_addr = self.memory.get_sp();
        } else if let Some(reg_num) = base_reg_name.strip_prefix('r') {
            let reg_idx: usize = reg_num.parse().expect("Failed to parse register index");
            base_addr = self.get_reg(reg_idx) as usize;
        }

        let effective_addr = ((base_addr as i32) + offset) as usize;

        if effective_addr < self.memory.heap.len() {
            self.memory.heap[effective_addr] = value;
        } else if effective_addr < self.memory.stack.len() {
            self.memory.stack[effective_addr] = value;
        }
    }

    fn flip_bit(&self, flipee: i32, bit: u32) -> i32 {
        let mask = 1 << bit;
        flipee ^ mask
    }
    fn flip_bit_u32(&self, flipee: u32, bit: u32) -> u32 {
        let mask = 1 << bit;
        flipee ^ mask
    }
    fn trigger_register_fault(&mut self, register: usize, bit: u32) {
        let old_val = self.registers[register];
        self.registers[register] = self.flip_bit(old_val, bit);
        println!("REGISTER FAULT TRIGGERED!");
    }

    pub fn execute(&mut self) -> u32 {
        self.parse_data_section();
        let start_block = self.get_start();
        if self.debug {
            eprintln!("DEBUG: start_block = {:?}", start_block);
        }
        while self.pc < self.eof_pc {
            let instruction = start_block.get(self.pc as usize).unwrap();

            if (self.pc as i32) == self.fault_spec.trigger_pc {
                match self.fault_spec.target {
                    InjectionTarget::Register { register, bit } => {
                        self.trigger_register_fault(register, bit);
                    }
                    InjectionTarget::ProgramCounter { bit } => {
                        self.pc = self.flip_bit_u32(self.pc, bit);
                        continue;
                    }
                    _ => panic!("Injection type not implemented yet."),
                }
            }

            if self.debug {
                eprintln!("DEBUG: PC={}, instruction={}", self.pc, instruction);
            }
            if self.start_time.elapsed().as_nanos() > self.max_time.as_nanos() {
                println!("Detected Infinite Loop");
                exit(88);
            }
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
                        return (exit_code as u32) & 0xff;
                    }
                }
                f if f.starts_with("sub") => self.exec_sub(instruction.clone()),
                // Important: check "strb" before "str" since "strb".starts_with("str") is true.
                f if f.starts_with("strb") => self.exec_strb(instruction.clone()),
                f if f.starts_with("str") => self.exec_str(instruction.clone()),
                f if f.starts_with("ldr") => self.exec_ldr(instruction.clone()),
                f if f.starts_with("cmp") => self.exec_cmp(instruction.clone()),
                f if f.starts_with("it") => self.exec_itx(instruction.clone()),
                f if f.starts_with("b") => {
                    self.exec_b(instruction.clone());
                    continue;
                }
                f if f.starts_with("add") => self.exec_add(instruction.clone()),
                f if f.starts_with("mul") => self.exec_mul(instruction.clone()),
                f if f.starts_with("sdiv") => self.exec_sdiv(instruction.clone()),
                f if f.contains(":") => {}
                invalid => panic!("Invalid instruction: {invalid}"),
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

            // Run qemu
            let qemu_exit = run_qemu(file_path);
            // Run interpreter
            let mut interp = Interpreter::new();
            interp.read_file(&file_path.to_string());
            let interp_exit = interp.execute();

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
        interp.set_reg(2, -1); // -1 in two's complement
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
