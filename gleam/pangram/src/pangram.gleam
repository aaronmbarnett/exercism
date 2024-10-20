import gleam/io
import gleam/list
import gleam/string

pub fn is_pangram(sentence: String) -> Bool {
  is_pangram_recursive(sentence, "")
}

fn is_pangram_recursive(sentence: String, acc: String) -> Bool {
  case string.pop_grapheme(sentence) {
    Ok(#(first_char, rest)) -> {
      let lc_first_char = string.lowercase(first_char)
      case lc_first_char {
        " "
        | "."
        | "_"
        | "1"
        | "2"
        | "3"
        | "4"
        | "5"
        | "6"
        | "7"
        | "8"
        | "9"
        | "0" -> is_pangram_recursive(rest, acc)
        _ ->
          case string.contains(acc, lc_first_char) {
            True -> is_pangram_recursive(rest, acc)
            False -> is_pangram_recursive(rest, acc <> lc_first_char)
          }
      }
    }
    Error(_) -> {
      let sorted_chars: String =
        string.split(acc, "")
        |> list.sort(string.compare)
        |> string.join("")
      sorted_chars == "abcdefghijklmnopqrstuvwxyz"
    }
  }
}
