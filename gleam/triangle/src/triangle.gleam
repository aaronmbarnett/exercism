pub fn equilateral(a: Float, b: Float, c: Float) -> Bool {
  case is_triangle(a, b, c) {
    True -> {
      case a == b, a == c, c == b {
        True, True, True -> True
        _, _, _ -> False
      }
    }
    False -> False
  }
}

pub fn isosceles(a: Float, b: Float, c: Float) -> Bool {
  case is_triangle(a, b, c) {
    True ->
      case a == b, a == c, c == b {
        True, _, _ -> True
        _, True, _ -> True
        _, _, True -> True
        _, _, _ -> False
      }
    False -> False
  }
}

pub fn scalene(a: Float, b: Float, c: Float) -> Bool {
  case is_triangle(a, b, c) {
    True ->
      case a == b, a == c, c == b {
        False, False, False -> True
        _, _, _ -> False
      }
    False -> False
  }
}

fn is_triangle(a: Float, b: Float, c: Float) -> Bool {
  case a >. 0.0, b >. 0.0, c >. 0.0 {
    True, True, True -> {
      case a +. b >=. c, b +. c >=. a, a +. c >=. b {
        True, True, True -> True
        _, _, _ -> False
      }
    }
    _, _, _ -> False
  }
}
