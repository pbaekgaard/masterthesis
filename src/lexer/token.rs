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
    True,
    False,
    IntegerLiteral(i64),
    StringLiteral(String),

    // Identifiers
    Identifier(String),

    // Operators
    Colon,       // :
    Arrow,       // ->
    Assign,      // =
    GreaterThan, // >
    LessThan, // <
    Equals,      // ==
    Plus,        // +
    Minus,       // -
    Multiply,    // *

    // Punctuation
    LeftParen,  // (
    RightParen, // )
    LeftBrace,  // {
    RightBrace, // }
    Comma,      // ,
    Semicolon,  // ;
}

#[derive(Debug, Clone)]
pub struct Token {
    pub token_type: TokenType,
    pub line: usize,
    pub column: usize,
}

impl Token {
    pub fn new(token_type: TokenType, line: usize, column: usize) -> Self {
        Token {
            token_type,
            line,
            column,
        }
    }
}
impl PartialEq for Token {
    fn eq(&self, other: &Self) -> bool {
        self.token_type == other.token_type &&
        self.line == other.line &&
        self.column == other.column
    }
}
