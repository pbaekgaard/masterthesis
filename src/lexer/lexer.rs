use crate::lexer::token::{Token, TokenType};



#[derive(Debug)]
pub struct Lexer {
    input: Vec<char>,
    position: usize,
    line: usize,
    column: usize
}

impl Lexer {
    pub fn new(input: String) -> Self{
        Self {
            input:input.chars().collect(),
            position: 0,
            line: 1,
            column: 1,
        }
    }
    pub fn tokenize(&mut self) -> Vec<Token> {
        let mut tokens: Vec<Token> = Vec::new();
        while let Some(ch) = self.current_char() {
            match ch {
                ' ' | '\t' => {
                    self.advance();
                }

                '\n' => {
                    self.advance_line();
                }
                '=' => {
                    self.simple_token(TokenType::Assign);
                }
                '+' => {
                    self.simple_token(TokenType::Plus);
                }
                '-' => {
                    self.simple_token(TokenType::Minus);
                }
                '*' => {
                    self.simple_token(TokenType::Multiply);
                }
                '{' => {
                    self.simple_token(TokenType::LeftBrace);
                }
                '}' => {
                    self.simple_token(TokenType::RightBrace);
                }
                '(' => {
                    self.simple_token(TokenType::LeftParen);
                }
                ')' => {
                    self.simple_token(TokenType::RightBrace);
                }
                _ => panic!("Suuuper wrongdog in here, unexpected char '{}' at {}:{}", ch, self.line, self.column),
            }
        }
        tokens
    }
    fn current_char(&self) -> Option<char> {
        self.input.get(self.position).copied()
    }

    fn advance(&mut self) {
        self.position += 1;
        self.column += 1;
    }

    fn advance_line(&mut self) {
        self.position += 1;
        self.line += 1;
        self.column = 1;
    }

    fn simple_token(&self, token_type: TokenType) -> Token {
        Token::new(token_type, self.line, self.column)
    }

    fn read_number(&mut self) -> Token {
        // TODO: implement this shi
        Token::new(TokenType::Integer, self.line, self.column)
    }

    fn read_identifier(&mut self) -> Token {
        // TODO: implement this shi
        Token::new(TokenType::Integer, self.line, self.column)
    }
    
}
impl PartialEq for Lexer {
    fn eq(&self, other: &Self) -> bool {
        self.input == other.input &&
        self.position == other.position &&
        self.column == other.column &&
        self.line == other.line
    }
}
mod tests{
    use crate::lexer::{lexer::Lexer, token::{Token, TokenType}};
    #[test]
    fn new_creates_lexer_correctly(){
        let actual = Lexer::new("a = 2".to_string());

        let expected = Lexer {
            input: vec!['a', ' ', '=', ' ', '2'],
            position: 0,
            line: 1,
            column: 1,
        };

        assert_eq!(actual, expected);
    }

    fn tokenize_works_as_intended(){
        let lex: &mut Lexer = Lexer::new("a = 2".to_string()); //wrongdog fix later
        let actualTokenVec: Vec<Token> = Lexer::tokenize(lex);

        let expected: Vec<Token> = vec![
            Token::new(TokenType::Identifier("a".to_string()), 1, 1), //idk if true, check later
            Token::new(TokenType::Assign, 1, 3), 
            Token::new(TokenType::Integer, 1, 5),
        ];

        assert_eq!(actualTokenVec, expected);// idk man i tried, does not work
    }
}