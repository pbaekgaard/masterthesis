mod lexer;

fn main() {
    
}

#[cfg(test)]
mod tests{
    use pretty_assertions::{assert_eq};

    use crate::lexer::lexer::Lexer;
    #[test]
    fn zero_eq_zero(){
        assert_eq!(0,0);
    }
}