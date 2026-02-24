use crate::lexer::token::{Token, TokenType};
#[derive(Debug, Clone, PartialEq)]
pub enum Stmt {
    Let(String, Type, Expr),
    AssignStatement(String, Expr),
    ExprStatement(Expr),
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
    Return(Expr)
}

#[derive(Debug, Clone, PartialEq)]
pub struct Function {
    pub name: String,
    pub params: Vec<Param>,
    pub return_type: Type,
    pub body: Block,
}
#[derive(Debug, Clone, PartialEq)]
pub struct Block {
    pub statements: Vec<Stmt>,
}
#[derive(Debug, Clone, PartialEq)]
pub struct Param {
    pub name: String,
    pub param_type: Type,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Type {
    Integer,
    Boolean,
}
#[derive(Debug, Clone, PartialEq)]
pub enum Expr {
    IntegerLiteral(i64),
    BooleanLiteral(bool),
    StringLiteral(String),
    Identifier(String),
    BinaryOp(Box<Expr>, BinOp, Box<Expr>),
    UnaryOp(UnOp, Box<Expr>),
    Call(Vec<Expr>), //I do not understand what this one is, but the expert recommended it
}

#[derive(Debug, Clone, PartialEq)]
pub enum BinOp {
    Add,
    Sub,
    Mul,
    Equals,
    NotEquals,
    GreaterThan,
    LessThan,
}

#[derive(Debug, Clone, PartialEq)]
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
            position: 0,
        }
    }
    pub fn parse_program(&mut self) -> AST {
        let mut ast: AST = Vec::new();
        while !self.match_token(TokenType::EOF) {
            match self.current().token_type {
                TokenType::Func => {
                    ast.push(self.parse_func());
                }
                _ => panic!(
                    "Wrong token {} at {}:{}",
                    self.current(),
                    self.current().line,
                    self.current().column,
                ),
            }
        }
        ast
    }
    //Todo: Implement the following funcs/helper funcs->
    fn parse_func(&mut self) -> Function {
        let _ = self.expect(TokenType::Func);

        let name = self.expect(TokenType::Identifier).unwrap().value;
        let _ = self.expect(TokenType::LeftParen);

        let mut params = Vec::new();
        while !self.match_token(TokenType::RightParen) {
            let name = self.expect(TokenType::Identifier).unwrap().value;
            let _ = self.expect(TokenType::Colon);

            let typevalue = match self.current().token_type {
                TokenType::Integer => {
                    let _ = self.expect(TokenType::Integer);
                    Type::Integer
                }
                TokenType::Boolean => {
                    let _ = self.expect(TokenType::Boolean);
                    Type::Boolean
                }
                _ => panic!("Unknown type for parameter"),
            };
            params.push(Param {
                name,
                param_type: typevalue,
            });
            if !self.match_token(TokenType::RightParen) {
                let _ = self.expect(TokenType::Comma);
            }
        }

        let _ = self.expect(TokenType::RightParen);

        let _ = self.expect(TokenType::Arrow);

        let return_type = match self.current().token_type {
            TokenType::Integer => {
                let _ = self.expect(TokenType::Integer);
                Type::Integer
            }
            TokenType::Boolean => {
                let _ = self.expect(TokenType::Boolean);
                Type::Boolean
            }
            _ => panic!(
                "Unknown return type for function: {}",
                self.current().token_type
            ),
        };

        let _ = self.expect(TokenType::LeftBrace);
        let body: Block = self.parse_block();
        let _ = self.expect(TokenType::RightBrace);
        Function {
            name,
            params,
            return_type,
            body,
        }
    }

    fn parse_block(&mut self) -> Block {
        let mut statements: Vec<Stmt> = Vec::new();

        while !self.match_token(TokenType::EOF) && !self.match_token(TokenType::RightBrace) {
            if self.match_token(TokenType::Let) {
                statements.push(self.parse_let()); //dingdong test commit after revert;
            } else if self.match_token(TokenType::If) {
                statements.push(self.parse_if());
            } else if self.match_token(TokenType::While) {
                statements.push(self.parse_while());
            } else if self.match_token(TokenType::Identifier) && self.peek(TokenType::Assign)
            {
                statements.push(self.parse_assignment());
            } else if self.match_token(TokenType::Return) {
                statements.push(self.parse_return());
            } 
            else {
                let expression = self.parse_expression();
                statements.push(Stmt::ExprStatement(expression));
            }
        }
        Block { statements }
    }
    fn parse_return(&mut self) -> Stmt{
        self.consume();
        let expr = self.parse_expression();
        let _ = self.expect(TokenType::Semicolon);
        Stmt::Return(expr)
    }

    fn parse_assignment(&mut self) -> Stmt{
        let var_name = self.expect(TokenType::Identifier).unwrap().value;
        let _ = self.expect(TokenType::Assign);
        let expr = self.parse_expression();
        let _ = self.expect(TokenType::Semicolon);
        Stmt::AssignStatement(var_name, expr)
    }

    fn parse_while(&mut self) -> Stmt{
        self.consume();
        let expr = self.parse_expression();
        let _ = self.expect(TokenType::Do);
        let _ = self.expect(TokenType::LeftBrace);
        let block = self.parse_block();
        let _ = self.expect(TokenType::RightBrace);
        Stmt::While { expr, block }
    }

    fn parse_if(&mut self) -> Stmt{
        self.consume();
        let condition = self.parse_expression();
        let _ = self.expect(TokenType::Then);
        let _ = self.expect(TokenType::LeftBrace);
        let block = self.parse_block();
        let _ = self.expect(TokenType::RightBrace);
        let option = match self.current().token_type {
            TokenType::Else => {
                self.consume();
                let _ = self.expect(TokenType::LeftBrace);
                Some(self.parse_block())
            }
            _ => None
        };
        let _ = self.expect(TokenType::RightBrace);
        Stmt::If { condition , block, option }
    }

    fn parse_let(&mut self) -> Stmt {
        self.consume();
        let var_name = self.expect(TokenType::Identifier).unwrap().value;
        let _ = self.expect(TokenType::Colon);
        let type_of_var = match self.current().token_type {
            TokenType::Integer => Type::Integer,
            TokenType::Boolean => Type::Boolean,
            _ => panic!(
                "Expected type, got something else at {}:{}",
                self.current().line,
                self.current().column
            ),
        };
        self.consume();
        let _ = self.expect(TokenType::Assign);
        let expr = self.parse_expression();
        let _ = self.expect(TokenType::Semicolon);
        Stmt::Let(var_name, type_of_var, expr)
    }

    fn token_to_binop(&self, tt: &TokenType) -> BinOp {
        match tt {
            TokenType::Plus => BinOp::Add,
            TokenType::Minus => BinOp::Sub,
            TokenType::Multiply => BinOp::Mul,
            TokenType::Equals => BinOp::Equals,
            TokenType::GreaterThan => BinOp::GreaterThan,
            TokenType::LessThan => BinOp::LessThan,
            _ => panic!("Not a binary operator"),
        }
    }

    fn parse_expression(&mut self) -> Expr {
        let tok = self.consume();
        match tok.token_type {
            TokenType::IntegerLiteral | TokenType::Identifier => {
                if self.match_any(&[
                    TokenType::Minus,
                    TokenType::Plus,
                    TokenType::Multiply,
                    TokenType::Division,
                    TokenType::GreaterThan,
                    TokenType::LessThan,
                    TokenType::Equals,
                ]) {
                    let op_token = self.consume();
                    let op = self.token_to_binop(&op_token.token_type);
                    let right = self.parse_expression();
                    Expr::BinaryOp(
                        match tok.token_type {
                            TokenType::IntegerLiteral => {
                                Box::new(Expr::IntegerLiteral(tok.value.parse::<i64>().unwrap()))
                            }
                            TokenType::Identifier => Box::new(Expr::Identifier(tok.value)),
                            _ => panic!("SOMETHING IS WRONGDOG"),
                        },
                        op,
                        Box::new(right),
                    )
                } else {
                    Expr::IntegerLiteral(tok.value.parse::<i64>().unwrap())
                }
            }
            TokenType::BooleanLiteral => {
                if self.match_token(TokenType::Equals) {
                    let op_token = self.consume();
                    let op = self.token_to_binop(&op_token.token_type);
                    let right = self.parse_expression();
                    Expr::BinaryOp(
                        Box::new(Expr::BooleanLiteral(tok.value.parse::<bool>().unwrap())),
                        op,
                        Box::new(right),
                    )
                } else if self.match_token(TokenType::Not) {
                    let _ = self.expect(TokenType::Equals);
                    let op = BinOp::NotEquals;
                    let right = self.parse_expression();
                    Expr::BinaryOp(
                        Box::new(Expr::BooleanLiteral(tok.value.parse::<bool>().unwrap())),
                        op,
                        Box::new(right),
                    )
                } else {
                    Expr::BooleanLiteral(tok.value.parse::<bool>().unwrap())
                }
            }
            TokenType::StringLiteral => {
                if self.match_token(TokenType::Equals) {
                    let op_token = self.consume();
                    let op = self.token_to_binop(&op_token.token_type);
                    let right = self.expect(TokenType::StringLiteral).unwrap();
                    Expr::BinaryOp(
                        Box::new(Expr::StringLiteral(tok.value.parse::<String>().unwrap())),
                        op,
                        Box::new(Expr::StringLiteral(right.value.parse::<String>().unwrap())),
                    )
                } else if self.match_token(TokenType::Not) {
                    let _ = self.expect(TokenType::Equals);
                    let op = BinOp::NotEquals;
                    let right = self.expect(TokenType::StringLiteral).unwrap();
                    Expr::BinaryOp(
                        Box::new(Expr::StringLiteral(tok.value.parse::<String>().unwrap())),
                        op,
                        Box::new(Expr::StringLiteral(right.value.parse::<String>().unwrap())),
                    )
                } else {
                    Expr::StringLiteral(tok.value.clone())
                }
            }
            TokenType::Not => {
                let exprs = self.parse_expression();
                Expr::UnaryOp(UnOp::Not, Box::new(exprs))
            }
            _ => panic!("Unexpected token {:?} in expression", tok.token_type),
        }
    }

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
    fn match_any(&self, types: &[TokenType]) -> bool {
        types.contains(&self.current().token_type)
    }
    fn expect(&mut self, expected: TokenType) -> Result<Token, String> {
        let tok = self.current();
        if tok.token_type == expected {
            Ok(self.consume())
        } else {
            Err(format!(
                "Expected {:?} at {}:{}, found {:?}",
                expected, tok.line, tok.column, tok.token_type
            ))
        }
    }
}

mod tests {

    use crate::parser::parser::Parser;
    use crate::{
        lexer::{
            lexer::Lexer,
            token::{Token, TokenType},
        },
        parser::parser::{AST, BinOp, Block, Expr, Function, Type},
    };

    #[test]
    fn test_parser_parses_correct_ast() {
        use crate::parser::parser::Stmt;
        use std::fs;
        let source = fs::read_to_string("simple.trv").expect("Failed to read file");
        let mut lexer = Lexer::new(source);
        let tokens = lexer.tokenize();
        let mut parser = Parser::new(tokens);
        let actual = parser.parse_program();

        let expected: AST = vec![Function {
            name: "main".to_string(),
            params: vec![],
            return_type: Type::Integer,
            body: Block {
                statements: vec![
                    Stmt::Let("num".to_string(), Type::Integer, Expr::IntegerLiteral(0)),
                    Stmt::While{
                        expr: Expr::BinaryOp(
                            Box::new(Expr::Identifier("num".to_string())),
                            BinOp::LessThan,
                            Box::new(Expr::IntegerLiteral(10))
                        ),
                        block: Block{
                            statements: vec![
                                Stmt::AssignStatement("num".to_string(), Expr::IntegerLiteral(11))
                            ]
                        }
                    },
                    Stmt::Return(Expr::Identifier("num".to_string()))
                ],
            },
        }];

        assert_eq!(actual, expected);
    }
}
