import gleam/int
import gleam/list

pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

// decorator pattern
pub type ExtraSauce(pizza) {
  ExtraSause(Pizza)
}

pub type ExtraTopping(pizza) {
  ExtraTopping(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  case pizza {
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
    ExtraSauce(p) -> 1 + pizza_price(p)
    ExtraToppings(p) -> 2 + pizza_price(p)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  let acc = case list.length(order) {
    1 -> 3
    2 -> 2
    _ -> 0
  }
  order_price_internal(order, acc)
}

fn order_price_internal(order: List(Pizza), acc: Int) -> Int {
  case order {
    [] -> acc
    [x, ..rest] -> order_price_internal(rest, acc + pizza_price(x))
  }
}
