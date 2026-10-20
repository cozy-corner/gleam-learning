# 安全な宝箱

ExercismのGleamトラックの安全な宝箱へようこそ。
テストの実行やコードの提出について助けが必要な場合は、`HELP.md`を確認してください。
演習で行き詰まったら、`HINTS.md`を確認してください。でも、まずはそれを使わずに解いてみましょう :)

## Introduction

## 不透明型

Gleamの不透明型とは、その型を定義したモジュールだけが値を作ったりパターンマッチしたりできるカスタム型のことです。決まった使い方だけを許したい型を作るときに便利です。

不透明型は、`opaque`キーワードを使って定義します。

```gleam
pub opaque type PositiveInt {
  PositiveInt(inner: Int)
}
```

この`PositiveInt`型は、整数を使いたいけれど0以上でなければならない場面で使います。通常のGleamの`Int`は負の値も取れるため、そのままでは使えません。

この型を定義したモジュールでは、内側の整数値を取り出す関数と、`PositiveInt`型を作る関数を定義できます。後者は、値が正でなければエラーを返します。

```gleam
pub fn from_int(i: Int) -> Result(PositiveInt, String) {
  case i {
    _ if i < 0 -> Error("Value must be positive")
    _ -> Ok(PositiveInt(i))
  }
}

pub fn to_int(i: PositiveInt) -> Int {
  i.inner
}
```

このAPIがあれば、ほかのモジュールが負の値で`PositiveInt`を作ることはできません。そのため、`PositiveInt`を受け取る関数は、その値が正であることを確信できます。

## Instructions

勘の鋭い方なら、前の演習の`TreasureChest`型がそれほど安全ではなかったことにお気づきでしょう。

`get_treasure`関数を使うときはパスワードを渡す必要がありましたが、パスワードを知らなくても`TreasureChest`型を分解すれば宝を取り出せてしまいました。

そこで、不透明型を使ってこれを解決しましょう。

## 1. `TreasureChest`不透明型を定義する

`TreasureChest`には2つのフィールドがあります。

- `String`型のパスワード。
- ジェネリック型の宝。

`TreasureChest`型は不透明でなければなりません。

## 2. `create`関数を定義する

この関数は2つの引数を取ります。

- `String`型のパスワード。
- 任意の型の宝の値。

この関数は、パスワードと値を持つ`TreasureChest`を返します。

パスワードが8文字より短い場合、この関数は`Password must be at least 8 characters long`というエラーを返します。

## 3. `open`関数を定義する

この関数は2つの引数を取ります。

- `TreasureChest`。
- `String`型のパスワード。

パスワードが`TreasureChest`内のパスワードと一致する場合、この関数は宝を返します。一致しない場合は、`Incorrect password`というエラーを返します。

## Source

### Created by

- @lpil