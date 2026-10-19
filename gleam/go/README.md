# 囲碁

ExercismのGleamトラックの囲碁へようこそ。
テストの実行やコードの提出について助けが必要な場合は、`HELP.md`を確認してください。
演習で行き詰まったら、`HINTS.md`を確認してください。でも、まずはそれを使わずに解いてみましょう :)

## Introduction

## `Result`

Gleamでは、エラー処理に例外を使いません。代わりに、成功するか失敗するかのどちらかになる関数からは、汎用的な`Result`型が返されます。

`Result`型は言語に組み込まれているので、自分で定義したりインポートしたりする必要はありません。ただし、自分で定義するとしたら、次のようになります。

```gleam
pub type Result(value, error) {
  Ok(value)
  Error(error)
}
```

関数が成功したときは`Ok`が返され、失敗したときは`Error`が返されます。

`Result`はGleamで非常によく使われるもので、Gleamプログラマーは、それらを扱いやすくするために[`gleam/result`モジュール](https://hexdocs.pm/gleam_stdlib/gleam/result.html)をよく利用します。

`result.map`関数を使うと、`Ok`の中に入っている値に関数を適用できます。`Error`の場合は、何も変更せずそのまま通します。

```gleam
Ok(1)
|> result.map(fn(x) { x + 1 })
// -> Ok(2)

Error("Oh no!")
|> result.map(fn(x) { x + 1 })
// -> Error("Oh no!")
```

`result.try`関数も似ていますが、こちらはコールバック関数が`Result`を返すことを想定しています。これは、`Result`を返す複数の関数をつなげるのに便利です。

```gleam
Ok(1)
|> result.try(fn(x) { Ok(x + 1) })
// -> Ok(2)

Ok(1)
|> result.try(fn(x) { Error("Nope!") })
// -> Error("Nope!")
```

## Instructions

この演習では、[囲碁のルール](https://matmoore.github.io/learngo/)を適用します。ルール自体はすでに書かれているので、あとはゲームを更新し、エラーやルール違反に対処するために、それらを適用するだけです。

ゲームは次のように表されます。

```gleam
pub type Player {
  Black
  White
}


pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}
```

ゲームには4つのルールがあります。

- 1つの点に置ける石は1つだけです。
- 相手の石は取ることができます。
- 自分の石が取られてしまう場所には石を置けません。
- 同じ点を2回使うことはできません。

## 1. ルールを適用する

`apply_rules`関数の内容を書きます。この関数は初期の`Game`と一連のルールを受け取り、ルールを適用した後の新しい`Game`を返します。

3つのルールはどれもルール違反をチェックし、エラーを返すことがあるため、戻り値の型は`Result(Game, String)`です。これらのルールのいずれかが失敗した場合は、元のゲームを返しますが、`error`フィールドには該当するエラーを設定します。

残りの1つのルールは違反をチェックしないため失敗せず（変更された`Game`を返すことはあります）、戻り値の型は`Game`です。

すべてのルールが通れば、ルールによる`Game`の変更はすべて反映し、プレイヤーを変更します。

```gleam
pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  // -> If all rules pass, return a `Game` with all changes from the rules applied, and change player
  // -> If any rule fails, return the original Game, but with the error field set
}
```

## Source

### Created by

- @lpil