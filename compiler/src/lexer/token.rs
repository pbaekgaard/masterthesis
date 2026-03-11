use std::fmt;

#[derive(Debug, Clone, PartialEq)]
pub enum TokenType {
    // Keywords
    Func,
    Let,
    If,
    Then,
    Else,
    Not,
    While,
    Print,
    Do,
    Is,

    // Types
    Integer,
    Boolean,

    // Literals
    BooleanLiteral,
    IntegerLiteral,
    StringLiteral,

    // Identifiers
    Identifier,

    // Operators
    Colon,       // :
    Arrow,       // ->
    Assign,      // =
    GreaterThan, // >
    LessThan,    // <
    Equals,      // ==
    NotEquals,      // !=
    Plus,        // +
    Minus,       // -
    Multiply,    // *
    Division,

    // Punctuation
    LeftParen,  // (
    RightParen, // )
    LeftBrace,  // {
    RightBrace, // }
    Comma,      // ,
    Semicolon,  // ;
    //special
    Return,
    EOF, // End of file
}

#[derive(Debug, Clone)]
pub struct Token {
    pub value: String,
    pub token_type: TokenType,
    pub line: usize,
    pub column: usize,
}

impl Token {
    pub fn new(value: String, token_type: TokenType, line: usize, column: usize) -> Self {
        Token {
            value: value,
            token_type,
            line,
            column,
        }
    }
}
impl fmt::Display for TokenType {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            // Keywords
            TokenType::Func => write!(f, "func"),
            TokenType::Let => write!(f, "let"),
            TokenType::If => write!(f, "if"),
            TokenType::Then => write!(f, "then"),
            TokenType::Else => write!(f, "else"),
            TokenType::Not => write!(f, "not"),
            TokenType::While => write!(f, "while"),
            TokenType::Print => write!(f, "print"),
            TokenType::Do => write!(f, "do"),
            TokenType::Is => write!(f, "is"),

            // Types
            TokenType::Integer => write!(f, "Integer"),
            TokenType::Boolean => write!(f, "Boolean"),

            // Literals
            TokenType::BooleanLiteral => write!(f, "BooleanLiteral"),
            TokenType::IntegerLiteral => write!(f, "IntegerLiteral"),
            TokenType::StringLiteral => write!(f, "StringLiteral"),

            // Identifiers
            TokenType::Identifier => write!(f, "Identifier"),

            // Operators
            TokenType::Colon => write!(f, ":"),
            TokenType::Arrow => write!(f, "->"),
            TokenType::Assign => write!(f, "="),
            TokenType::GreaterThan => write!(f, ">"),
            TokenType::LessThan => write!(f, "<"),
            TokenType::Equals => write!(f, "=="),
            TokenType::NotEquals => write!(f, "!="),
            TokenType::Plus => write!(f, "+"),
            TokenType::Minus => write!(f, "-"),
            TokenType::Multiply => write!(f, "*"),
            TokenType::Division => write!(f, "/"),

            // Punctuation
            TokenType::LeftParen => write!(f, "("),
            TokenType::RightParen => write!(f, ")"),
            TokenType::LeftBrace => write!(f, "{{"),
            TokenType::RightBrace => write!(f, "}}"),
            TokenType::Comma => write!(f, ","),
            TokenType::Semicolon => write!(f, ";"),
            TokenType::EOF => write!(f, "EOF"),
            TokenType::Return => write!(f, "Return"),
        }
    }
}

impl fmt::Display for Token {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{} at {}:{}", self.token_type, self.line, self.column)
    }
}
impl PartialEq for Token {
    fn eq(&self, other: &Self) -> bool {
        self.token_type == other.token_type
            && self.line == other.line
            && self.column == other.column
    }
}
