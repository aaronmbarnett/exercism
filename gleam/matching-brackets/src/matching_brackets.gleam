import gleam/string

pub fn is_paired(value: String) -> Bool {
  is_paired_recursive(value, [])
}

fn is_paired_recursive(value: String, stack: List(String)) -> Bool {
  case string.pop_grapheme(value) {
    Ok(#(first_char, rest_string)) -> {
      case first_char {
        "[" | "{" | "(" ->
          is_paired_recursive(rest_string, [first_char, ..stack])
        "]" | "}" | ")" -> {
          case stack {
            [] -> False
            [top_stack, ..rest] -> {
              case top_stack, first_char {
                "[", "]" -> is_paired_recursive(rest_string, rest)
                "(", ")" -> is_paired_recursive(rest_string, rest)
                "{", "}" -> is_paired_recursive(rest_string, rest)
                _, _ -> False
              }
            }
          }
        }
        _ -> is_paired_recursive(rest_string, stack)
      }
    }
    Error(_) -> stack == []
  }
}
