use crate::lexer::token::{self, Token, TokenType};
pub enum Stmt {
    Let(String, Expr),
    ExprStmt(Expr),
    If(Expr, Box<Stmt>, Option<Box<Stmt>>),
    While(Expr, Box<Stmt>),
    Block(Vec<Stmt>),
    Print(Expr),
    Function {
        name: String,
        params: Vec<Param>,
        return_type: Option<Expr>,
        body: Box<Stmt>,
    },
}
pub struct Param {
    name: String,
    param_type: Expr, // or some Type enum
}
pub enum Expr {
    Integer(i64),
    Boolean(bool),
    String(String),
    Variable(String),
    BinaryOp(Box<Expr>, BinOp, Box<Expr>),
    UnaryOp(UnOp, Box<Expr>),
    Call(String, Vec<Expr>), //I do not understand what this one is, but the expert recommended it
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
    tokens: Vec<Token>,
    position: usize
}

impl Parser {
    pub fn new(token_vector: Vec<Token>) -> Self{
        Self { 
            tokens: token_vector, 
            position: 1 
        }
    }
    pub fn parse_program(&mut self) -> AST {
        let mut ast: AST = Vec::new();
        while !self.match_token(TokenType::Eof) {
            match self.peek().token_type.clone() {
                TokenType::Func =>{
                    ast.push(self.parse_func());
                }
                TokenType::Let(a) => {
                    ast.push(self.parse_let());
                }
                _ => panic!("Wrong token {} at {}:{}", self.peek(), self.peek().line, self.peek().column)
            }
        }
        ast
    } 
    //Todo: Implement the following funcs/helper funcs->
    fn parse_func(&mut self) -> Stmt{
        self.expect(TokenType::Func);
        let name = self.expect()
    }

        // fn parse_expr

        // fn parse_bin_op

        // fn parse_un_op

        //Even more parse functions my fella

    //Here im making some helper functions i reckon mate
    fn peek(&self) -> &Token {
        self.tokens.get(self.position).unwrap()
    }

    fn advance(&mut self){
        self.position += 1;
    } 
    fn consume(&mut self)-> Token{
        let token = self.peek().clone();
        self.advance();
        token
    }
    fn match_token(&self, expected: TokenType) -> bool{
        self.peek().token_type == expected
    }
    fn expect(&mut self, expected: TokenType) -> Result<Token, String> {
        let tok = self.peek();
        if tok.token_type == expected {
            Ok(self.consume())
        }else{
            Err(format!("Expected {:?} at {}:{}, found {:?}", 
                expected, tok.line, tok.column, tok.token_type))
        }
    }

}