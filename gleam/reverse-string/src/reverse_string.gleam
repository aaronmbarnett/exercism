import gleam/list
import gleam/string

pub fn reverse(value: String) -> String {
  string.split(value, "")
  |> list.reverse
  |> string.join("")
}
