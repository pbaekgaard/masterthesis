use std::collections::HashMap;

#[derive(Debug, Clone, PartialEq)]
pub enum Type { 
    Integer,
    Boolean,
    String,
    Void,          //mayhaps not needed dunno, only if we allow functiions that dont return anything
    Function {
        params: Vec<Type>,
        return_type: Box<Type>,
    },
}

pub struct Symbol {
    name: String,
    symbol_type: Type,
    scope_level: usize,
    //perchance we need to add some more info, for functions (return types, param names)
}

impl Symbol {
    pub fn new(_name: String, s_type: Type, scope_lvl: usize ) -> Self{
        Self{
            name: _name,
            symbol_type: s_type,
            scope_level: scope_lvl,
        }
    }
}

pub struct SymbolTable {
    scopes: Vec<HashMap<String, Symbol>>,
}
impl SymbolTable {
    pub fn new() -> Self {
        Self{
            scopes: Vec::new(),
        }
    }
    pub fn enter_scope(&mut self) {
        self.scopes.push(HashMap::new());
    }
    pub fn exit_scope(&mut self) {
        if self.scopes.len() > 1 {
            self.scopes.pop();
        }
    }
    pub fn insert(&mut self, symbol: Symbol) -> Result<(), String> {
        let current = self.scopes.last_mut().unwrap();

        if current.contains_key(&symbol.name) {
            return Err(format!("Symbol '{}' already declared in this scope", symbol.name));
        }

        current.insert(symbol.name.clone(), symbol);
        Ok(())
    }
    pub fn lookup(&self, name: &str) -> Option<&Symbol> {
        for scope in self.scopes.iter().rev() {
            if let Some(symbol) = scope.get(name) {
                Some(symbol);
            }
        }
        None
    }
    pub fn lookup_current(&self, name: &str) -> Option<&Symbol> {
        self.scopes.last()?.get(name)
    }



}
