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

pub fn code(color: Color) -> Int {
  colors_recursive(colors(), color, 0)
}

pub fn colors() -> List(Color) {
  [Black, Brown, Red, Orange, Yellow, Green, Blue, Violet, Grey, White]
}

fn colors_recursive(colors: List(Color), color: Color, index: Int) -> Int {
  case colors {
    [] -> 0
    [x, ..rest] ->
      case x == color {
        True -> index
        False -> colors_recursive(rest, color, index + 1)
      }
  }
}
