import gleam/string

type RomanMap {
  RomanMap(num: Int, str: String)
}

pub fn convert(number: Int) -> String {
  let roman_map = [
    RomanMap(1000, "M"),
    RomanMap(900, "CM"),
    RomanMap(500, "D"),
    RomanMap(400, "CD"),
    RomanMap(100, "C"),
    RomanMap(90, "XC"),
    RomanMap(50, "L"),
    RomanMap(40, "XL"),
    RomanMap(10, "X"),
    RomanMap(9, "IX"),
    RomanMap(5, "V"),
    RomanMap(4, "IV"),
    RomanMap(1, "I"),
  ]
  case roman_map {
    [] -> ""
    [RomanMap(arabic_number, roman_numeral), ..rest] -> {
      case number >= arabic_number {
        True -> string.append(roman_numeral, convert(number - arabic_number))
        False -> convert_recursive(number, rest)
      }
    }
  }
}

fn convert_recursive(number: Int, roman_map: List(RomanMap)) -> String {
  case roman_map {
    [] -> ""
    [RomanMap(arabic_number, roman_numeral), ..rest] -> {
      case number >= arabic_number {
        True ->
          string.append(
            roman_numeral,
            convert_recursive(number - arabic_number, roman_map),
          )
        False -> convert_recursive(number, rest)
      }
    }
  }
}
