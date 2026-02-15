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
        // TODO: 
    }

    fn read_identifier(&mut self) -> Token {
        // TODO:
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
    use crate::lexer::lexer::Lexer;
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
}