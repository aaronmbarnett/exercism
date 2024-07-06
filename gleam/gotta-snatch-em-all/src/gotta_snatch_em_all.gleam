import gleam/list
import gleam/set.{type Set}
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  set.from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  #(set.contains(collection, card), set.insert(collection, card))
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let hypothetical_collection =
    collection |> set.delete(my_card) |> set.insert(their_card)

  case
    set.contains(collection, my_card),
    set.contains(collection, their_card),
    my_card
    == their_card
  {
    True, False, False -> #(True, hypothetical_collection)
    _, _, _ -> #(False, hypothetical_collection)
  }
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  case collections {
    [first_collection, ..rest] ->
      list.fold(rest, first_collection, fn(acc, collection) {
        set.intersection(acc, collection)
      })
    [] -> set.new()
  }
  |> set.to_list
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  list.fold(over: collections, from: set.new(), with: fn(acc, collection) {
    set.union(acc, collection)
  })
  |> set.size
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  collection
  |> set.filter(fn(card) { string.starts_with(card, "Shiny ") })
}
