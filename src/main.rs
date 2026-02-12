fn main() {
    println!("Hello, world!");
}

#[cfg(test)]
mod tests{
    use pretty_assertions::{assert_eq};
    #[test]
    fn zero_eq_zero(){
        assert_eq!(0,0);
    }
}