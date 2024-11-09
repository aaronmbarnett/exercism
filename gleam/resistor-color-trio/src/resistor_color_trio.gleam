import gleam/float
import gleam/int
import gleam/list

pub type Resistance {
  Resistance(unit: String, value: Int)
}

pub fn label(colors: List(String)) -> Result(Resistance, Nil) {
  let assert [first_band, ..last_two] = colors
  let assert [second_band, ..last] = last_two
  let assert [last_band, ..] = last
  let last_num_string = map_color_to_number(last_band)
  let assert Ok(last_num) = int.parse(last_num_string)
  let val_as_string =
    map_color_to_number(first_band) <> map_color_to_number(second_band)
  let assert Ok(result_number) = float.parse(val_as_string <> ".0")
  let assert Ok(exponent) = int.power(10, int.to_float(last_num))
  let total = result_number *. exponent
  get_prefix(total)
}

fn map_color_to_number(color: String) -> String {
  case color {
    "black" -> "0"
    "brown" -> "1"
    "red" -> "2"
    "orange" -> "3"
    "yellow" -> "4"
    "green" -> "5"
    "blue" -> "6"
    "violet" -> "7"
    "grey" -> "8"
    "white" -> "9"
    _ -> "0"
  }
}

fn get_prefix(val: Float) -> Result(Resistance, Nil) {
  let metric_prefixes = [
    #("giga", 1_000_000_000.0),
    #("mega", 1_000_000.0),
    #("kilo", 1000.0),
    #("", 1.0),
    #("", 0.0),
  ]

  list.find_map(metric_prefixes, fn(prefix_tuple) {
    let #(prefix, factor) = prefix_tuple
    case val >=. factor {
      True -> Ok(Resistance(prefix <> "ohms", float.round(val /. factor)))
      False -> Error(Nil)
    }
  })
}
