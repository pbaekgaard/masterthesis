const STACK_SIZE: usize = 1024 * 1024;
const HEAP_SIZE: usize = 1024 * 1024;

pub struct EmulatorMemory {
    stack: Vec<u8>,
    heap: Vec<u8>,
    heap_alloc_index: usize,
    stack_pointer: usize,
}

impl EmulatorMemory {
    pub fn new() -> Self {
        Self {
            stack: vec![0; STACK_SIZE],
            heap: vec![0; HEAP_SIZE],
            heap_alloc_index: 0,
            stack_pointer: STACK_SIZE,
        }
    }

    pub fn push32(&mut self, value: u32) {
        let bytes = value.to_le_bytes();
        self.stack[self.stack_pointer..self.stack_pointer + 4].copy_from_slice(&bytes);
    }

    pub fn pop32(&mut self) -> u32 {
        let bytes = [
            self.stack[self.stack_pointer],
            self.stack[self.stack_pointer + 1],
            self.stack[self.stack_pointer + 2],
            self.stack[self.stack_pointer + 3],
        ];
        u32::from_le_bytes(bytes)
    }

    pub fn push16(&mut self, value: u16) {
        let bytes = value.to_le_bytes();
        self.stack[self.stack_pointer..self.stack_pointer + 2].copy_from_slice(&bytes);
    }

    pub fn pop16(&mut self) -> u16 {
        let bytes = [
            self.stack[self.stack_pointer],
            self.stack[self.stack_pointer + 1],
        ];
        u16::from_le_bytes(bytes)
    }

    pub fn alloc(&mut self, size: usize) -> Result<usize, String> {
        if self.heap_alloc_index + size > HEAP_SIZE {
            return Err("Out of heap memory".to_string());
        }
        let addr = self.heap_alloc_index;
        self.heap_alloc_index += size;
        Ok(addr)
    }

    pub fn read32(&self, addr: usize) -> u32 {
        let bytes = [
            self.heap[addr],
            self.heap[addr + 1],
            self.heap[addr + 2],
            self.heap[addr + 3],
        ];
        u32::from_le_bytes(bytes)
    }

    pub fn write32(&mut self, addr: usize, value: u32) {
        self.heap[addr..addr + 4].copy_from_slice(&value.to_le_bytes());
    }

    pub fn write_stack32(&mut self, offset: usize, value: u32) {
        let addr = self.stack_pointer + offset;
        self.stack[addr..addr + 4].copy_from_slice(&value.to_le_bytes());
    }

    pub fn read_stack32(&self, offset: usize) -> u32 {
        let addr = self.stack_pointer + offset;

        if addr + 4 > self.stack.len() {
            panic!("Stack out of bounds read at offset {}", offset);
        }

        u32::from_le_bytes([
            self.stack[addr],
            self.stack[addr + 1],
            self.stack[addr + 2],
            self.stack[addr + 3],
        ])
    }

    pub fn get_sp(&self) -> usize {
        self.stack_pointer
    }

    pub fn set_sp(&mut self, sp: usize) {
        self.stack_pointer = sp;
    }

    pub fn get_heap_alloc_index(&self) -> usize {
        self.heap_alloc_index
    }

    pub fn get_heap_size(&self) -> usize {
        self.heap.len()
    }

    pub fn get_heap(&self) -> &Vec<u8> {
        &self.heap
    }

    pub fn get_stack(&self) -> &Vec<u8> {
        &self.stack
    }
}

impl Default for EmulatorMemory {
    fn default() -> Self {
        Self::new()
    }
}
