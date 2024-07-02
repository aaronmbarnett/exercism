import gleam/list

pub fn today(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [x, ..] -> x
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [] -> [1]
    [_, ..rest] -> [today(days) + 1, ..rest]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  case days {
    [] -> False
    [x, ..rest] ->
      case x {
        0 -> True
        _ -> has_day_without_birds(rest)
      }
  }
}

pub fn total(days: List(Int)) -> Int {
  list.fold(days, 0, fn(acc, num_birds_in_day) { acc + num_birds_in_day })
}

pub fn busy_days(days: List(Int)) -> Int {
  list.fold(days, 0, fn(acc, num_birds_in_day) {
    case num_birds_in_day {
      count if count > 4 -> acc + 1
      _ -> acc
    }
  })
}
