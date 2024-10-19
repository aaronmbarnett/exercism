import gleam/float
import gleam/order.{Eq, Gt, Lt}

pub fn score(x: Float, y: Float) -> Int {
  let x_squared = float.multiply(x, x)
  let y_squared = float.multiply(y, y)
  let product = float.add(x_squared, y_squared)
  let outer_radius = float.multiply(10.0, 10.0)
  let mid_radius = float.multiply(5.0, 5.0)
  let inner_radius = float.multiply(1.0, 1.0)
  case float.compare(product, inner_radius) {
    Lt -> 10
    Eq -> 10
    Gt ->
      case float.compare(product, mid_radius) {
        Lt -> 5
        Eq -> 5
        Gt ->
          case float.compare(product, outer_radius) {
            Lt -> 1
            Eq -> 1
            Gt -> 0
          }
      }
  }
}
