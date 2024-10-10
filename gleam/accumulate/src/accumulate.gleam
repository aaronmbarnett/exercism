pub fn accumulate(list: List(a), fun: fn(a) -> b) -> List(b) {
  accumulate_recursive(list, fun)
}

fn accumulate_recursive(list: List(a), the_function: fn(a) -> b) -> List(b) {
  case list {
    [] -> []
    [a, ..rest] -> [the_function(a), ..accumulate_recursive(rest, the_function)]
  }
}
