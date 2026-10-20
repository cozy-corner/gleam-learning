import gleam/int
import gleam/list

// Please define the Usd type
pub type Usd

// Please define the Eur type
pub type Eur

// Please define the Jpy type
pub type Jpy

// Please define the Money type
pub opaque type Money(currency) {
  Money(price: Int)
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


// acc は雪だるまのイメージ
pub fn total(prices: List(Money(currency))) -> Money(currency) {
  list.fold(prices, Money(0), fn(acc, x) { Money(acc.price + x.price) })
}

pub fn total_with_pipe(prices: List(Money(currency))) -> Money(currency) {
  prices
  |> list.map(fn(m) {m.price})
  |> int.sum
  |> Money
}
