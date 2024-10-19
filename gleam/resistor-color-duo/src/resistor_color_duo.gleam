import gleam/int
import gleam/io
import gleam/list
import gleam/string

pub type Color {
  Black
  Brown
  Red
  Orange
  Yellow
  Green
  Blue
  Violet
  Grey
  White
}

pub fn value(colors: List(Color)) -> Result(Int, Nil) {
  let str_result = value_recursive(colors)
  case str_result {
    Ok(resistance_value) -> int.parse(string.slice(resistance_value, 0, 2))
    Error(Nil) -> Error(Nil)
  }
}

pub fn value_recursive(colors: List(Color)) -> Result(String, Nil) {
  case list.length(colors) < 2 {
    False -> something_recursive(colors, "")
    True -> Error(Nil)
  }
}

fn something_recursive(list: List(Color), acc: String) -> Result(String, Nil) {
  case list {
    [] -> Ok(acc)
    [x, ..rest] -> {
      case x {
        Black -> {
          something_recursive(rest, acc <> "0")
        }
        Brown -> {
          something_recursive(rest, acc <> "1")
        }
        Red -> {
          something_recursive(rest, acc <> "2")
        }
        Orange -> {
          something_recursive(rest, acc <> "3")
        }
        Yellow -> {
          something_recursive(rest, acc <> "4")
        }
        Green -> {
          something_recursive(rest, acc <> "5")
        }
        Blue -> {
          something_recursive(rest, acc <> "6")
        }
        Violet -> {
          something_recursive(rest, acc <> "7")
        }
        Grey -> {
          something_recursive(rest, acc <> "8")
        }
        White -> {
          something_recursive(rest, acc <> "9")
        }
      }
    }
  }
}
