import gleam/int
import gleam/list

pub fn is_armstrong_number(number: Int) -> Bool {
  case int.digits(number, 10) {
    Ok(digits) -> {
      let len = list.length(digits)
      let sum =
        digits
        |> list.map(fn(digit) { int.product(list.repeat(digit, len)) })
        |> int.sum
      number == sum
    }
    Error(_) -> False
  }
}
