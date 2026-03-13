use crate::lexer::token::{Token, TokenType};

#[derive(Debug)]
pub struct Lexer {
    input: Vec<char>,
    position: usize,
    line: usize,
    column: usize,
}

impl Lexer {
    pub fn new(input: String) -> Self {
        Self {
            input: input.chars().collect(),
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
                'A'..='Z' | 'a'..='z' | '_' => {
                    tokens.push(self.read_identifier(ch));
                }
                '0'..='9' => {
                    tokens.push(self.read_number(ch));
                }
                '=' => {
                    tokens.push(self.assign_or_equals());
                }
                '!' => {
                    tokens.push(self.not_or_notequals());
                }
                ':' => {
                    tokens.push(self.simple_token(ch.to_string(), TokenType::Colon));
                }
                '+' => {
                    tokens.push(self.simple_token(ch.to_string(), TokenType::Plus));
                }
                '-' => {
                    tokens.push(self.minus_or_arrow());
                }
                '*' => {
                    tokens.push(self.simple_token(ch.to_string(), TokenType::Multiply));
                }
                '/' => {
                    tokens.push(self.simple_token(ch.to_string(), TokenType::Division));
                }
                '{' => {
                    tokens.push(self.simple_token(ch.to_string(), TokenType::LeftBrace));
                }
                '}' => {
                    tokens.push(self.simple_token(ch.to_string(), TokenType::RightBrace));
                }
                '(' => {
                    tokens.push(self.simple_token(ch.to_string(), TokenType::LeftParen));
                }
                ')' => {
                    tokens.push(self.simple_token(ch.to_string(), TokenType::RightParen));
                }
                '>' => {
                    tokens.push(self.simple_token(ch.to_string(), TokenType::GreaterThan));
                }
                '<' => {
                    tokens.push(self.simple_token(ch.to_string(), TokenType::LessThan));
                }
                ';' => {
                    tokens.push(self.simple_token(ch.to_string(), TokenType::Semicolon));
                }
                '"' => {
                    tokens.push(self.read_string_literal());
                }
                ',' => {
                    tokens.push(self.simple_token(ch.to_string(), TokenType::Comma));
                }
                '#' => {
                    self.read_comment();
                }
                _ => panic!(
                    "Suuuper wrongdog in here, unexpected char '{}' at {}:{}",
                    ch, self.line, self.column
                ),
            }
        }
        tokens.push(self.simple_token("EOF".to_string(), TokenType::EOF));
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

    fn simple_token(&mut self, value: String, token_type: TokenType) -> Token {
        let start_col_num = self.column;
        self.advance();
        Token::new(value, token_type, self.line, start_col_num)
    }
    fn assign_or_equals(&mut self) -> Token {
        let original_col = self.column;
        self.advance();
        if self.current_char().unwrap() == '=' {
            let line = self.line.clone();
            self.advance();
            Token::new("==".to_string(), TokenType::Equals, line, original_col)
        } else {
            Token::new("=".to_string(), TokenType::Assign, self.line, original_col)
        }
    }

    fn not_or_notequals(&mut self) -> Token {
        let original_col = self.column;
        self.advance();
        if self.current_char().unwrap() == '=' {
            let line = self.line.clone();
            self.advance();
            Token::new("!=".to_string(), TokenType::NotEquals, line, original_col)
        } else {
            Token::new("!".to_string(), TokenType::Not, self.line, original_col)
        }
    }

    fn minus_or_arrow(&mut self) -> Token {
        let original_col = self.column;
        self.advance();
        if self.current_char().unwrap() == '>' {
            self.advance();
            Token::new("->".to_string(), TokenType::Arrow, self.line, original_col)
        } else {
            Token::new("-".to_string(), TokenType::Minus, self.line, original_col)
        }
    }
    fn read_comment(&mut self) {
        while let Some(ch) = self.current_char() {
            match ch {
                '\n' => {
                    break;
                }
                _ => {
                    self.advance();
                }
            }
        }
    }
    fn read_number(&mut self, first_ch: char) -> Token {
        let mut num_string: String = "".to_string();
        let start_col_num: usize = self.column;
        num_string.push(first_ch);
        self.advance();
        while let Some(ch) = self.current_char() {
            match ch {
                '0'..='9' => {
                    num_string.push(ch);
                    self.advance();
                }
                _ => {
                    break;
                }
            }
        }
        let num = num_string.parse::<i64>().unwrap();
        Token::new(
            num_string,
            TokenType::IntegerLiteral,
            self.line,
            start_col_num,
        )
    }

    fn read_string_literal(&mut self) -> Token {
        let mut the_litteral: String = "".to_string();
        let start_col_num: usize = self.column;
        the_litteral.push('"');
        self.advance();
        while let Some(ch) = self.current_char() {
            match ch {
                '"' => {
                    the_litteral.push(ch);
                    self.advance();
                    break;
                }
                _ => {
                    the_litteral.push(ch);
                    self.advance();
                }
            }
        }
        Token::new(
            the_litteral.clone(),
            TokenType::StringLiteral,
            self.line,
            start_col_num,
        )
    }

    fn read_identifier(&mut self, first_ch: char) -> Token {
        let mut name: String = "".to_string();
        let start_col_num: usize = self.column;
        name.push(first_ch);
        self.advance();
        while let Some(ch) = self.current_char() {
            match ch {
                'A'..='Z' | 'a'..='z' | '_' | '0'..='9' => {
                    name.push(ch);
                    self.advance();
                }
                _ => {
                    break;
                }
            }
        }
        self.give_keyword_or_literal_token(name.as_mut_str(), self.line, start_col_num)
    }
    fn give_keyword_or_literal_token(&mut self, name: &str, line: usize, col: usize) -> Token {
        match name {
            "let" => Token::new("let".to_string(), TokenType::Let, line, col),
            "func" => Token::new("func".to_string(), TokenType::Func, line, col),
            "if" => Token::new("if".to_string(), TokenType::If, line, col),
            "then" => Token::new("then".to_string(), TokenType::Then, line, col),
            "else" => Token::new("else".to_string(), TokenType::Else, line, col),
            "not" => Token::new("not".to_string(), TokenType::Not, line, col),
            "while" => Token::new("while".to_string(), TokenType::While, line, col),
            "print" => Token::new("print".to_string(), TokenType::Print, line, col),
            "do" => Token::new("do".to_string(), TokenType::Do, line, col),
            "is" => Token::new("is".to_string(), TokenType::Is, line, col),
            "Integer" => Token::new("Integer".to_string(), TokenType::Integer, line, col),
            "Boolean" => Token::new("Boolean".to_string(), TokenType::Boolean, line, col),
            "return" => Token::new("Return".to_string(), TokenType::Return, line, col),
            "True" => Token::new("True".to_string(), TokenType::BooleanLiteral, line, col),
            "False" => Token::new("False".to_string(), TokenType::BooleanLiteral, line, col),
            _ => Token::new(name.to_string(), TokenType::Identifier, line, col),
        }
    }
}
impl PartialEq for Lexer {
    fn eq(&self, other: &Self) -> bool {
        self.input == other.input
            && self.position == other.position
            && self.column == other.column
            && self.line == other.line
    }
}

#[cfg(test)]
mod tests {
    use crate::lexer::{
        lexer::Lexer,
        token::{Token, TokenType},
    };
    #[test]
    fn new_creates_lexer_correctly() {
        let actual = Lexer::new("a = 2".to_string());

        let expected = Lexer {
            input: vec!['a', ' ', '=', ' ', '2'],
            position: 0,
            line: 1,
            column: 1,
        };

        assert_eq!(actual, expected);
    }
    #[test]
    fn tokenize_works_as_intended() {
        let mut lex: Lexer = Lexer::new("abc_def = 2".to_string());
        let actual_token_vec: Vec<Token> = lex.tokenize();

        let expected: Vec<Token> = vec![
            Token::new("abc_def".to_string(), TokenType::Identifier, 1, 1),
            Token::new("=".to_string(), TokenType::Assign, 1, 9),
            Token::new(2.to_string(), TokenType::IntegerLiteral, 1, 11),
            Token::new("EOF".to_string(), TokenType::EOF, 1, 12),
        ];

        assert_eq!(actual_token_vec, expected);
    }
    #[test]
    fn reading_comments_tokenize_lexer_line_col_are_correct() {
        let mut lex: Lexer = Lexer::new("#abc_def = 2\n".to_string());
        lex.tokenize();
        assert_eq!((lex.line, lex.column), (2, 2));
    }
    #[test]
    fn reading_comments_tokenize_returns_eof_vector() {
        let mut lex: Lexer = Lexer::new("#abc_def = 2\n".to_string());
        let actual_token_vec: Vec<Token> = lex.tokenize();

        let expected: Vec<Token> = vec![Token::new("EOF".to_string(), TokenType::EOF, 2, 1)];

        assert_eq!(actual_token_vec, expected);
    }
    #[test]
    fn read_string_literal_makes_correct_token() {
        let mut lex: Lexer = Lexer::new("\"test\"".to_string());
        let actual_token_vec: Vec<Token> = lex.tokenize();

        let expected: Vec<Token> = vec![
            Token::new("\"test\"".to_string(), TokenType::StringLiteral, 1, 1),
            Token::new("EOF".to_string(), TokenType::EOF, 1, 7),
        ];

        assert_eq!(actual_token_vec, expected);
    }
}
