use crate::lexer::token::{Token, TokenType};
pub enum Expr {
    Integer(i64),
    Boolean(bool),
    String(String),
    Variable(String),
    BinaryOp(Box<Expr>, BinOp, Box<Expr>),
    UnaryOp(UnOp, Box<Expr>),
    Call(String, Vec<Expr>), //I do not understand what this one is, but the expert recommended it
}

pub enum Stmt {
    Let(String, Expr),
    ExprStmt(Expr),
    If(Expr, Box<Stmt>, Option<Box<Stmt>>),
    While(Expr, Box<Stmt>),
    Block(Vec<Stmt>),
    Print(Expr),
}

pub enum BinOp {
    Add,
    Sub,
    Mul,
    Equals,
    GreaterThan,
    LessThan,
}

pub enum UnOp {
    Not,
    Neg,
}
pub type AST = Vec<Stmt>;
pub struct Parser{
    input: Vec<Token>,
    position: usize
}

impl Parser {
    pub fn new(token_vector: Vec<Token>) -> Self{
        Self { 
            input: Vec::new(), 
            position: 1 
        }
    }
    pub fn parse_program(&mut self) -> AST {
        Vec::new() //Todo: implement
    } 
    //Todo: Implement the following funcs/helper funcs->
        // fn parse_stmt

        // fn parse_expr

        // fn parse_term

        // fn parse_factor

        //Even more parse functions my fella

    //Here im making some helper functions i reckon mate

        //peek (look at current token without consuming)

    fn advance(&mut self){
        self.position += 1;
    } 

    fn expect(&mut self, expected: TokenType) -> Result<Token, String> {
        let tok = self.input.get(self.position).unwrap();
        if tok.token_type == expected {
            Ok(tok.clone())
        }else{
            Err(format!("Expected {:?} at {}:{}, found {:?}", 
                expected, tok.line, tok.column, tok.token_type))
        }
    }

}