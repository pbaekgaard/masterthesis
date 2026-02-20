use crate::lexer::token::{ self, Token, TokenType };
pub enum Stmt {
    Let(String, Type, Expr),
    ExprStmt(Expr),
    If {
        condition: Expr,
        block: Block,
        option: Option<Block>,
    },
    While {
        expr: Expr,
        block: Block,
    },
    Print(Expr),
}

pub struct Function {
    pub name: String,
    pub params: Vec<Param>,
    pub return_type: Type,
    pub body: Block,
}
pub struct Block {
    pub statements: Vec<Stmt>,
}
pub struct Param {
    name: String,
    param_type: Type, // or some Type enum
}

pub enum Type {
    Integer,
    Boolean,
}
pub enum Expr {
    IntegerLiteral(i64),
    BooleanLiteral(bool),
    StringLiteral(String),
    Identifier(String),
    BinaryOp(Box<Expr>, BinOp, Box<Expr>),
    UnaryOp(UnOp, Box<Expr>),
    Call(Vec<Expr>), //I do not understand what this one is, but the expert recommended it
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
}
pub type AST = Vec<Function>;
pub struct Parser {
    tokens: Vec<Token>,
    position: usize,
}

impl Parser {
    pub fn new(token_vector: Vec<Token>) -> Self {
        Self {
            tokens: token_vector,
            position: 1,
        }
    }
    pub fn parse_program(&mut self) -> AST {
        let mut ast: AST = Vec::new();
        while !self.match_token(TokenType::Eof) {
            match self.current().token_type.clone() {
                TokenType::Func => {
                    ast.push(self.parse_func());
                }
                _ =>
                    panic!(
                        "Wrong token {} at {}:{}",
                        self.current(),
                        self.current().line,
                        self.current().column
                    ),
            }
        }
        ast
    }
    //Todo: Implement the following funcs/helper funcs->
    fn parse_func(&mut self) -> Function {
        self.expect(TokenType::Func);

        let name = self.expect(TokenType::Identifier).unwrap().value;
        self.expect(TokenType::LeftParen);

        let mut params = Vec::new();
        while !self.match_token(TokenType::RightParen) {
            let name = self.expect(TokenType::Identifier).unwrap().value;
            self.expect(TokenType::Colon);

            let mut typevalue;
            match self.current().token_type {
                TokenType::Integer => {
                    self.expect(TokenType::Integer);
                    typevalue = Type::Integer;
                }
                TokenType::Boolean => {
                    self.expect(TokenType::Boolean);
                    typevalue = Type::Boolean;
                }
                _ => panic!("Unknown type for parameter"),
            }
            params.push(Param { name: name, param_type: typevalue });
            if !self.match_token(TokenType::RightParen) {
                self.expect(TokenType::Comma);
            }
        }

        self.expect(TokenType::RightParen);

        self.expect(TokenType::Arrow);

        let mut return_type;
        match self.current().token_type {
            TokenType::Integer => {
                self.expect(TokenType::Integer);
                return_type = Type::Integer;
            }
            TokenType::Boolean => {
                self.expect(TokenType::Boolean);
                return_type = Type::Boolean;
            }
            _ => panic!("Unknown return type for function"),
        }

        self.expect(TokenType::LeftBrace);
        let body: Block = self.parse_block();
        Function { name, params, return_type, body }
    }

    fn parse_block(&mut self) -> Block {
        let mut statements: Vec<Stmt> = Vec::new();
        let cur_tok = self.current();
        while !self.match_token(TokenType::Eof) && !self.match_token(TokenType::RightBrace) {
            if self.match_token(TokenType::Let) {
                statements.push(self.parse_let()); //dingdong test commit after revert;
            } else if self.match_token(TokenType::If) {
                statements.push(self.parse_if());
            } else if self.match_token(TokenType::While) {
                statements.push(self.parse_while());
            } else if
                self.match_token(TokenType::Identifier) &&
                self.match_token(TokenType::Assign)
            {
                statements.push(self.parse_assignment());
            } else {
                let expression = self.parse_expression();
                statements.push(Stmt::ExprStmt(expression));
            }
        }
        Block { statements }
    }

    fn parse_let(&mut self) -> Stmt {
        self.consume();
        let var_name = self.expect(TokenType::Identifier).unwrap().value;
        self.expect(TokenType::Colon);
        let type_of_var = match self.current().token_type {
            TokenType::Integer => Type::Integer,
            TokenType::Boolean => Type::Boolean,
            _ =>
                panic!(
                    "Expected type, got something else at {}:{}",
                    self.current().line,
                    self.current().column
                ),
        };
        self.consume();
        self.expect(TokenType::Assign);
        let expr = self.parse_expression();
        Stmt::Let(var_name, type_of_var, expr)
    }
    fn parse_expression(&mut self) -> Expr {
        let tok = self.consume();
        match tok.token_type {
            TokenType::Integer => {
                if
                    self.match_any(
                        &[
                            TokenType::Minus,
                            TokenType::Plus,
                            TokenType::Multiply,
                            TokenType::Division,
                            TokenType::GreaterThan,
                            TokenType::LessThan,
                            TokenType::Equals,
                        ]
                    )
                {
                    Expr::BinaryOp(Expr::IntegerLiteral(tok.value.parse::<i64>().unwrap()), , ())
                }else{
                    Expr::IntegerLiteral(tok.value.parse::<i64>().unwrap())
                }
            }
            TokenType::Boolean => Expr::BooleanLiteral(tok.value.parse::<bool>().unwrap()),
            TokenType::StringLiteral => Expr::StringLiteral(tok.value.clone()),
            TokenType::Identifier => Expr::Identifier(tok.value.clone()),
            TokenType::Not => {
                let exprs = self.parse_expression();
                Expr::UnaryOp(UnOp::Not, Box::new(exprs))
            }
            _ => panic!(""),
        }
    }
    // fn parse_expr

    // fn parse_bin_op

    // fn parse_un_op

    //Even more parse functions my fella

    //Here im making some helper functions i reckon mate
    fn peek(&self, token_type: TokenType) -> bool {
        if self.position + 1 < self.tokens.len() {
            self.tokens.get(self.position + 1).unwrap().token_type == token_type
        } else {
            false
        }
    }

    fn current(&self) -> &Token {
        self.tokens.get(self.position).unwrap()
    }

    fn advance(&mut self) {
        self.position += 1;
    }
    fn consume(&mut self) -> Token {
        let token = self.current().clone();
        self.advance();
        token
    }
    fn match_token(&self, expected: TokenType) -> bool {
        self.current().token_type == expected
    }
    fn match_any(&self, token_types: &[TokenType]) -> bool {
        token_types.contains(&self.current().token_type)
    }
    fn expect(&mut self, expected: TokenType) -> Result<Token, String> {
        let tok = self.current();
        if tok.token_type == expected {
            Ok(self.consume())
        } else {
            Err(
                format!(
                    "Expected {:?} at {}:{}, found {:?}",
                    expected,
                    tok.line,
                    tok.column,
                    tok.token_type
                )
            )
        }
    }
}
