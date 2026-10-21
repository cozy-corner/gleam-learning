# ピザの価格計算

ExercismのGleamトラックのピザの価格計算へようこそ。
テストの実行やコードの提出について助けが必要な場合は、`HELP.md`を確認してください。
演習で行き詰まったら、`HINTS.md`を確認してください。でも、まずはそれを使わずに解いてみましょう :)

## Introduction

## 末尾呼び出し最適化

関数が呼び出されるたびに、その関数の引数とローカル変数を保存するための新しいスタックフレームがメモリ上に作成され、関数が戻るとこのスタックフレームは解放されます。Gleamでは、ループ構文の代わりに再帰的な関数呼び出しを使うため、こうしたスタックフレームによって大量のメモリが使われてしまうことがあります。

この問題を避けるために、Gleamは末尾呼び出し最適化をサポートしています。これにより、関数が最後に行うことが関数呼び出しであれば、コンパイラーは現在の関数のスタックフレームを再利用できます。つまり、追加のメモリをまったく使わずに、関数が自分自身を無限に呼び出せるということです。

最適化されていない再帰関数は、_アキュムレーター_を使うことで、末尾呼び出し最適化された関数に書き換えられることがよくあります。

アキュムレーターとは、データに加えて引き渡される変数のことです。ベースケースに到達するまで、関数の実行の現在の状態を引き継いでいくために使われます。

アキュムレーターは、関数の利用者ではなく、関数の作者が初期化するべきです。そのためには、2つの関数を宣言します。必要なデータだけを引数に取り、アキュムレーターを初期化する公開関数と、アキュムレーターも受け取る非公開関数です。

```gleam
// Count the length of a list without tail call optimisation
pub fn count(list: List(String)) -> Int {
  case list {
    [] -> 0
    [_, ..rest] -> {
      let amount = count(rest) // Non-tail recursive call
      amount + 1
    }
  }
}
```

```gleam
// Count the length of a list with tail call optimisation
pub fn count(list: List(String)) -> Int {
  count_elements(list, 0)
}

fn count_elements(list: List(String), accumulator: Int) -> Int {
  case list {
    [] -> accumulator
    [_, ..rest] -> {
      let accumulator = accumulator + 1
      count_elements(rest, accumulator) // Tail recursive call
    }
  }
}
```

## Instructions

この演習では、お客さんにピザを配達するピザ屋で働きます。

提供しているピザは3種類あります。

- Margherita: \$7
- Caprese: \$9
- Formaggio: \$10

お客さんは、少額の追加料金で2つのオプションも選べます。

1. Extra sauce: \$1
1. Extra toppings: \$2

お客さんが注文するとき、ピザを1枚か2枚しか注文しない場合は追加料金がかかります。

- 1 pizza: \$3
- 2 pizzas: \$2

この演習には3つのタスクがあり、それぞれピザとその価格を扱います。

## 1. ピザの種類とオプションを定義する

ピザの種類とオプションを表すために、カスタム型`Pizza`を定義します。

- `Margherita`
- `Caprese`
- `Formaggio`
- `ExtraSauce`
- `ExtraToppings`

`ExtraSauce`と`ExtraToppings`は、`Pizza`型を包むようにします。

## 2. ピザの価格を計算する

ピザの価格を計算する`pizza_price`関数を実装します。

```gleam
pizza_price(Caprese)
// -> 9
```

## 3. 注文の価格を計算する

ピザの注文の価格を計算する`order_price`関数を実装します。

```gleam
order_price([Margherita, Formaggio])
// -> 19
```

## Source

### Created by

- @lpil