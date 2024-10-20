import gleam/list
import gleam/string

pub fn is_isogram(phrase phrase: String) -> Bool {
  is_isogram_recursive(phrase, [])
}

fn is_isogram_recursive(phrase: String, acc: List(String)) -> Bool {
  case string.length(phrase) == 0 {
    True -> True
    False -> {
      case string.pop_grapheme(phrase) {
        Ok(#(first_char, rest)) ->
          case first_char {
            "-" | " " -> is_isogram_recursive(rest, acc)
            _ ->
              case list.contains(acc, string.lowercase(first_char)) {
                True -> False
                False ->
                  is_isogram_recursive(rest, [
                    string.lowercase(first_char),
                    ..acc
                  ])
              }
          }
        Error(_) -> False
      }
    }
  }
}
