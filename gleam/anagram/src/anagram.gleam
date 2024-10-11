import gleam/list
import gleam/string

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  find_anagrams_recursive(word, candidates)
}

fn find_anagrams_recursive(
  word: String,
  candidates: List(String),
) -> List(String) {
  let sorted_target_word = sort_characters(word)

  case candidates {
    [] -> []
    [candidate_word, ..rest] -> {
      let sorted_candidate_word = sort_characters(candidate_word)
      case sorted_candidate_word == sorted_target_word {
        True ->
          case string.lowercase(word) == string.lowercase(candidate_word) {
            True -> find_anagrams_recursive(word, rest)
            False -> [candidate_word, ..find_anagrams_recursive(word, rest)]
          }
        False -> find_anagrams_recursive(word, rest)
      }
    }
  }
}

fn sort_characters(word: String) -> String {
  string.lowercase(word)
  |> string.split("")
  |> list.sort(string.compare)
  |> string.join("")
}
