use crate::{ lexer::token::{ Token, TokenType } };
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
    Print(Vec<Expr>),
    Return(Expr),
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
    Call(Vec<Expr>),
}

impl Expr {
    /// Recursively traverses the expression and appends a suffix to all Identifiers.
    pub fn duplicate_identifiers(&self, suffix: &str) -> Self {
        match self {
            Expr::Identifier(name) => { Expr::Identifier(format!("{}{}", name, suffix)) }
            Expr::BinaryOp(left, op, right) => {
                Expr::BinaryOp(
                    Box::new(left.duplicate_identifiers(suffix)),
                    op.clone(),
                    Box::new(right.duplicate_identifiers(suffix))
                )
            }
            Expr::UnaryOp(op, expr) => {
                Expr::UnaryOp(op.clone(), Box::new(expr.duplicate_identifiers(suffix)))
            }
            Expr::Call(args) => {
                let dup_args = args
                    .iter()
                    .map(|arg| arg.duplicate_identifiers(suffix))
                    .collect();
                Expr::Call(dup_args)
            }
            // Literals don't contain identifiers, so they remain unchanged
            Expr::IntegerLiteral(_) | Expr::BooleanLiteral(_) | Expr::StringLiteral(_) => {
                self.clone()
            }
        }
    }
    pub fn get_all_identifiers(&self) -> Vec<String> {
        let mut identifiers = Vec::new();
        self.collect_identifiers(&mut identifiers);
        identifiers
    }

    // A private helper function that passes a mutable reference
    // to avoid allocating multiple vectors during recursion.
    fn collect_identifiers(&self, acc: &mut Vec<String>) {
        match self {
            Expr::Identifier(name) => {
                acc.push(name.clone());
            }
            Expr::BinaryOp(left, _, right) => {
                left.collect_identifiers(acc);
                right.collect_identifiers(acc);
            }
            Expr::UnaryOp(_, expr) => {
                expr.collect_identifiers(acc);
            }
            Expr::Call(args) => {
                for arg in args {
                    arg.collect_identifiers(acc);
                }
            }
            // Literals do not contain any identifiers
            Expr::IntegerLiteral(_) | Expr::BooleanLiteral(_) | Expr::StringLiteral(_) => {}
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
pub enum BinOp {
    Add,
    Sub,
    Mul,
    Div,
    Equals,
    NotEquals,
    GreaterThan,
    LessThan,
}

#[derive(Debug, Clone, PartialEq)]
pub enum UnOp {
    Not,
    Neg,
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
            _ => panic!("Unknown return type for function: {}", self.current().token_type),
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
            } else if self.match_token(TokenType::Print) {
                statements.push(self.parse_print());
            } else if self.match_token(TokenType::Identifier) && self.peek(TokenType::Assign) {
                statements.push(self.parse_assignment());
            } else if self.match_token(TokenType::Return) {
                statements.push(self.parse_return());
            } else {
                let expression = self.parse_expression();
                statements.push(Stmt::ExprStatement(expression));
            }
        }
        Block { statements }
    }
    fn parse_print(&mut self) -> Stmt {
        // 'print' already matched by caller
        self.consume(); // consume 'print'
        let _ = self.expect(TokenType::LeftParen);

        let mut args: Vec<Expr> = Vec::new();
        // allow empty argument list: print();
        if !self.match_token(TokenType::RightParen) {
            args.push(self.parse_expression());
            while self.match_token(TokenType::Comma) {
                self.consume(); // consume ','
                args.push(self.parse_expression());
            }
        }

        let _ = self.expect(TokenType::RightParen);
        let _ = self.expect(TokenType::Semicolon);
        Stmt::Print(args)
    }
    fn parse_return(&mut self) -> Stmt {
        self.consume();
        let expr = self.parse_expression();
        let _ = self.expect(TokenType::Semicolon);
        Stmt::Return(expr)
    }

    fn parse_assignment(&mut self) -> Stmt {
        let var_name = self.expect(TokenType::Identifier).unwrap().value;
        let _ = self.expect(TokenType::Assign);
        let expr = self.parse_expression();
        let _ = self.expect(TokenType::Semicolon);
        Stmt::AssignStatement(var_name, expr)
    }

    fn parse_while(&mut self) -> Stmt {
        self.consume();
        let expr = self.parse_expression();
        let _ = self.expect(TokenType::Do);
        let _ = self.expect(TokenType::LeftBrace);
        let block = self.parse_block();
        let _ = self.expect(TokenType::RightBrace);
        Stmt::While { expr, block }
    }

    fn parse_if(&mut self) -> Stmt {
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
            _ => None,
        };
        if option.is_some() {
            let _ = self.expect(TokenType::RightBrace);
        }
        Stmt::If {
            condition,
            block,
            option,
        }
    }

    fn parse_let(&mut self) -> Stmt {
        self.consume();
        let var_name = self.expect(TokenType::Identifier).unwrap().value;
        let _ = self.expect(TokenType::Colon);
        let type_of_var = match self.current().token_type {
            TokenType::Integer => Type::Integer,
            TokenType::Boolean => Type::Boolean,
            _ =>
                panic!(
                    "Expected type, got {:?} ({}) at {}:{}",
                    self.current().token_type,
                    self.current().value,
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
            TokenType::Division => BinOp::Div,
            TokenType::Equals => BinOp::Equals,
            TokenType::NotEquals => BinOp::NotEquals,
            TokenType::GreaterThan => BinOp::GreaterThan,
            TokenType::LessThan => BinOp::LessThan,
            _ => panic!("Not a binary operator"),
        }
    }

    fn parse_expression(&mut self) -> Expr {
        self.parse_equality()
    }

    fn parse_equality(&mut self) -> Expr {
        let mut left = self.parse_comparison();
        loop {
            if self.match_any(&[TokenType::Equals, TokenType::NotEquals]) {
                let op = self.token_to_binop(&self.current().token_type);
                self.consume();
                let right = self.parse_comparison();
                left = Expr::BinaryOp(Box::new(left), op, Box::new(right));
            } else {
                break;
            }
        }
        left
    }

    fn parse_comparison(&mut self) -> Expr {
        let mut left = self.parse_additive();
        loop {
            if self.match_any(&[TokenType::GreaterThan, TokenType::LessThan]) {
                let op = self.token_to_binop(&self.current().token_type);
                self.consume();
                let right = self.parse_additive();
                left = Expr::BinaryOp(Box::new(left), op, Box::new(right));
            } else {
                break;
            }
        }
        left
    }

    fn parse_additive(&mut self) -> Expr {
        let mut left = self.parse_multiplicative();
        loop {
            if self.match_any(&[TokenType::Plus, TokenType::Minus]) {
                let op = self.token_to_binop(&self.current().token_type);
                self.consume();
                let right = self.parse_multiplicative();
                left = Expr::BinaryOp(Box::new(left), op, Box::new(right));
            } else {
                break;
            }
        }
        left
    }

    fn parse_multiplicative(&mut self) -> Expr {
        let mut left = self.parse_unary();
        loop {
            if self.match_any(&[TokenType::Multiply, TokenType::Division]) {
                let op = self.token_to_binop(&self.current().token_type);
                self.consume();
                let right = self.parse_unary();
                left = Expr::BinaryOp(Box::new(left), op, Box::new(right));
            } else {
                break;
            }
        }
        left
    }

    fn parse_unary(&mut self) -> Expr {
        if self.match_token(TokenType::Not) {
            self.consume();
            let expr = self.parse_unary();
            return Expr::UnaryOp(UnOp::Not, Box::new(expr));
        }
        if self.match_token(TokenType::Minus) {
            self.consume();
            let expr = self.parse_unary();
            return Expr::UnaryOp(UnOp::Neg, Box::new(expr));
        }
        self.parse_primary()
    }

    fn parse_primary(&mut self) -> Expr {
        let tok = self.consume();
        match tok.token_type {
            TokenType::IntegerLiteral => { Expr::IntegerLiteral(tok.value.parse::<i64>().unwrap()) }
            TokenType::Identifier => {
                if self.match_token(TokenType::LeftParen) {
                    self.consume();
                    let mut args = Vec::new();
                    if !self.match_token(TokenType::RightParen) {
                        args.push(self.parse_expression());
                        while self.match_token(TokenType::Comma) {
                            self.consume();
                            args.push(self.parse_expression());
                        }
                    }
                    let _ = self.expect(TokenType::RightParen);
                    Expr::Call(args)
                } else {
                    Expr::Identifier(tok.value)
                }
            }
            TokenType::BooleanLiteral => {
                Expr::BooleanLiteral(tok.value.to_lowercase().parse::<bool>().unwrap())
            }
            TokenType::StringLiteral => Expr::StringLiteral(tok.value),
            TokenType::LeftParen => {
                let expr = self.parse_expression();
                let _ = self.expect(TokenType::RightParen);
                expr
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

#[cfg(test)]
mod tests {
    use crate::parser::parser::Parser;
    use crate::parser::parser::Stmt;
    use crate::{
        lexer::lexer::Lexer,
        parser::parser::{ BinOp, Block, Expr, Function, Type, UnOp, AST },
    };

    #[test]
    fn test_parser_parses_correct_ast() {
        use std::fs;
        let source = fs
            ::read_to_string("test_codes/test_correct_ast.trv")
            .expect("Failed to read file");
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
                    Stmt::While {
                        expr: Expr::BinaryOp(
                            Box::new(Expr::Identifier("num".to_string())),
                            BinOp::LessThan,
                            Box::new(Expr::IntegerLiteral(10))
                        ),
                        block: Block {
                            statements: vec![
                                Stmt::AssignStatement("num".to_string(), Expr::IntegerLiteral(11))
                            ],
                        },
                    },
                    Stmt::If {
                        condition: Expr::BinaryOp(
                            Box::new(Expr::Identifier("num".to_string())),
                            BinOp::GreaterThan,
                            Box::new(Expr::IntegerLiteral(10))
                        ),
                        block: Block {
                            statements: vec![
                                Stmt::AssignStatement("num".to_string(), Expr::IntegerLiteral(12))
                            ],
                        },
                        option: Some(Block {
                            statements: vec![
                                Stmt::AssignStatement("num".to_string(), Expr::IntegerLiteral(11))
                            ],
                        }),
                    },
                    Stmt::Return(Expr::Identifier("num".to_string()))
                ],
            },
        }];

        assert_eq!(actual, expected);
    }

    fn parse_expr(source: &str) -> Expr {
        let full = format!("func test() -> Integer {{ return {}; }}", source);
        let mut lexer = Lexer::new(full);
        let tokens = lexer.tokenize();
        let mut parser = Parser::new(tokens);
        let ast = parser.parse_program();
        match &ast[0].body.statements[0] {
            Stmt::Return(e) => e.clone(),
            _ => panic!("Expected return statement"),
        }
    }

    #[test]
    fn test_mul_binds_tighter_than_add() {
        let ast = parse_expr("1 + 2 * 3");
        let expected = Expr::BinaryOp(
            Box::new(Expr::IntegerLiteral(1)),
            BinOp::Add,
            Box::new(
                Expr::BinaryOp(
                    Box::new(Expr::IntegerLiteral(2)),
                    BinOp::Mul,
                    Box::new(Expr::IntegerLiteral(3))
                )
            )
        );
        assert_eq!(ast, expected);
    }

    #[test]
    fn test_add_binds_tighter_than_mul() {
        let ast = parse_expr("1 * 2 + 3");
        let expected = Expr::BinaryOp(
            Box::new(
                Expr::BinaryOp(
                    Box::new(Expr::IntegerLiteral(1)),
                    BinOp::Mul,
                    Box::new(Expr::IntegerLiteral(2))
                )
            ),
            BinOp::Add,
            Box::new(Expr::IntegerLiteral(3))
        );
        assert_eq!(ast, expected);
    }

    #[test]
    fn test_relational_binds_tighter_than_equality() {
        let ast = parse_expr("a == b < c");
        let expected = Expr::BinaryOp(
            Box::new(Expr::Identifier("a".to_string())),
            BinOp::Equals,
            Box::new(
                Expr::BinaryOp(
                    Box::new(Expr::Identifier("b".to_string())),
                    BinOp::LessThan,
                    Box::new(Expr::Identifier("c".to_string()))
                )
            )
        );
        assert_eq!(ast, expected);
    }

    #[test]
    fn test_additive_binds_tighter_than_relational() {
        let ast = parse_expr("a < b + c");
        let expected = Expr::BinaryOp(
            Box::new(Expr::Identifier("a".to_string())),
            BinOp::LessThan,
            Box::new(
                Expr::BinaryOp(
                    Box::new(Expr::Identifier("b".to_string())),
                    BinOp::Add,
                    Box::new(Expr::Identifier("c".to_string()))
                )
            )
        );
        assert_eq!(ast, expected);
    }

    #[test]
    fn test_add_is_left_associative() {
        let ast = parse_expr("1 + 2 + 3");
        let expected = Expr::BinaryOp(
            Box::new(
                Expr::BinaryOp(
                    Box::new(Expr::IntegerLiteral(1)),
                    BinOp::Add,
                    Box::new(Expr::IntegerLiteral(2))
                )
            ),
            BinOp::Add,
            Box::new(Expr::IntegerLiteral(3))
        );
        assert_eq!(ast, expected);
    }

    #[test]
    fn test_mul_is_left_associative() {
        let ast = parse_expr("1 * 2 * 3");
        let expected = Expr::BinaryOp(
            Box::new(
                Expr::BinaryOp(
                    Box::new(Expr::IntegerLiteral(1)),
                    BinOp::Mul,
                    Box::new(Expr::IntegerLiteral(2))
                )
            ),
            BinOp::Mul,
            Box::new(Expr::IntegerLiteral(3))
        );
        assert_eq!(ast, expected);
    }

    #[test]
    fn test_mixed_precedence_complex() {
        let ast = parse_expr("1 + 2 * 3 - 4 / 2");
        let expected = Expr::BinaryOp(
            Box::new(
                Expr::BinaryOp(
                    Box::new(Expr::IntegerLiteral(1)),
                    BinOp::Add,
                    Box::new(
                        Expr::BinaryOp(
                            Box::new(Expr::IntegerLiteral(2)),
                            BinOp::Mul,
                            Box::new(Expr::IntegerLiteral(3))
                        )
                    )
                )
            ),
            BinOp::Sub,
            Box::new(
                Expr::BinaryOp(
                    Box::new(Expr::IntegerLiteral(4)),
                    BinOp::Div,
                    Box::new(Expr::IntegerLiteral(2))
                )
            )
        );
        assert_eq!(ast, expected);
    }

    #[test]
    fn test_parentheses_override_precedence() {
        let ast = parse_expr("(1 + 2) * 3");
        let expected = Expr::BinaryOp(
            Box::new(
                Expr::BinaryOp(
                    Box::new(Expr::IntegerLiteral(1)),
                    BinOp::Add,
                    Box::new(Expr::IntegerLiteral(2))
                )
            ),
            BinOp::Mul,
            Box::new(Expr::IntegerLiteral(3))
        );
        assert_eq!(ast, expected);
    }

    #[test]
    fn test_unary_neg_precedence() {
        let ast = parse_expr("-1 * 2");
        let expected = Expr::BinaryOp(
            Box::new(Expr::UnaryOp(UnOp::Neg, Box::new(Expr::IntegerLiteral(1)))),
            BinOp::Mul,
            Box::new(Expr::IntegerLiteral(2))
        );
        assert_eq!(ast, expected);
    }

    #[test]
    fn test_not_precedence() {
        let ast = parse_expr("not True == False");
        let expected = Expr::BinaryOp(
            Box::new(Expr::UnaryOp(UnOp::Not, Box::new(Expr::BooleanLiteral(true)))),
            BinOp::Equals,
            Box::new(Expr::BooleanLiteral(false))
        );
        assert_eq!(ast, expected);
    }
}
