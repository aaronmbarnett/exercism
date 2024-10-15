import gleam/list
import gleam/string

pub fn slices(input: String, size: Int) -> Result(List(String), Error) {
  slices_recursive(input, size, [])
}

fn slices_recursive(
  input: String,
  size: Int,
  acc: List(String),
) -> Result(List(String), Error) {
  let len = string.length(input)
  case size {
    i if i < 0 -> Error(SliceLengthNegative)
    i if i == 0 -> Error(SliceLengthZero)
    _ ->
      case len > 0 {
        True ->
          case size > len {
            True -> Error(SliceLengthTooLarge)
            False -> build_list(input, size, acc)
          }
        False -> Error(EmptySeries)
      }
  }
}

fn build_list(
  input: String,
  size: Int,
  acc: List(String),
) -> Result(List(String), Error) {
  case string.length(input) {
    0 -> {
      Ok(list.reverse(acc))
    }
    i if i < size -> Ok(list.reverse(acc))
    _ -> {
      let substring = string.slice(input, 0, size)
      let rest = string.slice(input, 1, string.length(input) - 1)
      build_list(rest, size, [substring, ..acc])
    }
  }
}

pub type Error {
  SliceLengthTooLarge
  EmptySeries
  SliceLengthZero
  SliceLengthNegative
}
