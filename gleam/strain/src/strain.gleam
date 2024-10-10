pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  keep_recursive(list, predicate)
}

fn keep_recursive(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  case list {
    [] -> []
    [x, ..rest] ->
      case predicate(x) {
        True -> [x, ..keep_recursive(rest, predicate)]
        False -> keep_recursive(rest, predicate)
      }
  }
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  case list {
    [] -> []
    [x, ..rest] ->
      case predicate(x) {
        True -> discard(rest, predicate)
        False -> [x, ..discard(rest, predicate)]
      }
  }
}
