// TODO: please define the Pizza custom type
pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  case pizza {
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
    ExtraSauce(p) -> pizza_price(p) + 1
    ExtraToppings(p) -> pizza_price(p) + 2
  }
}

fn total_order(order: List(Pizza), acc: Int) {
  case order {
    [] -> acc
    [x, ..rest] -> {
      let acc = acc + pizza_price(x)
      total_order(rest, acc)
    }
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  case order {
    [] -> 0
    [_] -> total_order(order, 0) + 1
    [_, _] -> total_order(order, 0) + 2
    _ -> total_order(order, 0)
  }
}
