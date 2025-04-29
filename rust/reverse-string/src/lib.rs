pub fn reverse(input: &str) -> String {
    let mut result = String::new();
    let char_array: Vec<char> = input.chars().collect();
    let mut stack = vec![];
    for c in char_array {
        stack.push(c);
    }
    for c in stack {
        result.insert(0, c);
    }
    result

    // idiomatic reverse
    // input.chars().rev().collect()
}
