import gleam/list

// Please define the Usd type
pub type Usd

// Please define the Eur type
pub type Eur

// Please define the Jpy type
pub type Jpy

// Please define the Money type
pub opaque type Money(currency) {
  Money(amount: Int)
}

pub fn dollar(amount: Int) -> Money(Usd) {
  Money(amount)
}

pub fn euro(amount: Int) -> Money(Eur) {
  Money(amount)
}

pub fn yen(amount: Int) -> Money(Jpy) {
  Money(amount)
}

pub fn total(prices: List(Money(currency))) -> Money(currency) {
  let total =
    list.fold(prices, 0, fn(acc, price) {
      let amount = price.amount
      amount + acc
    })
  Money(total)
}
