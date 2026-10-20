# ステッカーショップ

ExercismのGleamトラックのステッカーショップへようこそ。
テストの実行やコードの提出について助けが必要な場合は、`HELP.md`を確認してください。
演習で行き詰まったら、`HINTS.md`を確認してください。でも、まずはそれを使わずに解いてみましょう :)

## Introduction

## ファントム型

ファントム型とは、カスタム型の型パラメーターのうち、その型の値コンストラクターで使われていないものを指します。

少し抽象的ですね。例を見てみましょう。

```gleam
pub type Length(unit) {
  Length(amount: Float)
}
```

この例では、`unit`という型パラメーターは`Length`の値コンストラクターで使われていないので、`unit`はファントム型です。

この使われていない型パラメーターは無駄に見えるかもしれませんが、`Length`の値をどのように使えるかに、さらなる制約を加えるために利用できます。

たとえば、長さを2倍にする`double`という関数を考えてみましょう。これはどの単位の長さでも動作するので、型パラメーターはジェネリックな型変数になります。

```gleam
// This function accepts all Length values
pub fn double(length: Length(unit)) -> Length(unit) {
  Length(length.amount *. 2.0)
}
```

また、長さがインチである場合にだけ動作する`add_inch`という関数も考えられます。

```gleam
// A unit type for inches. It is never constructed so we don't
// define any constructors for it.
pub type Inches

pub fn add_inch(length: Length(Inches)) -> Length(Inches) {
  Length(length.amount +. 1.0)
}
```

`add_inch`関数は、それ以外の単位パラメーターを持つ長さを受け付けません。ファントム型は、正しい単位だけが使われるようにするために使われています。

同じ型変数を両方に使うことで、2つの長さの値が同じ単位であることを保証する関数も書けます。

```gleam
pub fn add(a: Length(unit), b: Length(unit)) -> Length(unit) {
  Length(a.amount +. b.amount)
}
```
```gleam
let two_meters: Length(Meters) = Length(2.0)
let two_inches: Length(Inches) = Length(2.0)

add(two_meters, two_meters)
// -> Length(4.0): Length(Meters)

add(two_meters, two_inches)
// Type error! The unit type parameters do not match.
```

ファントム型は、不透明型と組み合わせるとうまく機能します。ほかのモジュールが`Length`の値を作れないようにすれば、無効な単位の型で値が作られないこと、そしてそれらに使えるのは上で定義した関数だけであることを保証できます。

## Instructions

ルーシーはオンラインでステッカーショップを開いていて、みんなが大好きなプログラミング言語をあしらった、かわいいステッカーを販売しています。世界中の人たちが彼女のステッカーを買ってくれるのですが、ルーシーはさまざまな通貨の扱いに少し困っています。

ルーシーが価格を計算するときに、いつも正しい通貨を使えていると確信できるようなプログラムを作りましょう。

## 1. `Usd`、`Eur`、`Jpy`型を定義しましょう

これらの型は、ルーシーのお客さんがステッカーを買うときに使う、さまざまな通貨を表すためのものです。

ファントム型として使うものなので、コンストラクターを用意する必要はありません。

## 2. `Money`型を定義しましょう

`Money`型は、金額を表す`Int`のフィールドと通貨のファントム型パラメーターを持ち、不透明型である必要があります。

## 3. `dollar`、`euro`、`yen`関数を定義しましょう

`dollar`、`euro`、`yen`関数を定義します。これらの関数は`Int`の値を受け取り、正しい通貨を持つ`Money`の値を返します。

## 4. `total`関数を定義しましょう

`total`関数を定義します。この関数は`Money`の値の配列を受け取り、その配列に入っている金額の合計を返します。

```gleam
total([euro(120), euro(200), euro(145)])
// -> euro(465)
```

## Source

### Created by

- @lpil