

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