use std::collections::HashMap;
pub struct Symbol {
    symbol_type: Type,
    scope_level: usize,
    //perchance we need to add some more info, for functions (return types, param names)
}

pub struct SymbolTable {
    scopes: Vec<HashMap<String, Symbol>>, 
    //key = name i figured, so no "name" property in Symbol struct
}