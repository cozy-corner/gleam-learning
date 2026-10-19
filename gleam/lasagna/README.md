# ラザニア

ExercismのGleamトラックのラザニアへようこそ。
テストの実行やコードの提出について助けが必要な場合は、`HELP.md`を確認してください。
演習で行き詰まったら、`HINTS.md`を確認してください。でも、まずはそれを使わずに解いてみましょう :)

## Introduction

## 基本

### 関数

Gleamでは、関数は`pub fn`という構文で定義します。

```gleam
pub fn add(x: Int, y: Int) -> Int {
  x + y
}
```

この関数は`Int`型の引数を2つ取り、`Int`型の値を返します。Gleamには`return`というキーワードはありません。関数の最後の式の値が、常に_暗黙的に戻り値になります_。

引数の型注釈と戻り値の型は省略できます。また、Gleamは常にコード全体の型チェックを行います。通常、Gleamプログラマーは明確にするために型注釈を付けますが、必要なければ省略してもかまいません。

```gleam
pub fn add(x, y) {
  x + y
}
```

関数は`function_name(argument1, argument2)`という構文で呼び出せます。

```gleam
pub fn double(x: Int) -> Int {
  // Call the add function defined above
  add(x, x)
}
```

### 変数

Gleamでは、変数は`let name = expression`という構文で定義します。

```gleam
pub fn main() {
  let count = 1
}
```

変数は型注釈を付けて宣言することもできます。関数の引数と同様、これは省略可能ですが、ほとんどのGleamプログラマーは簡潔さのために変数の型注釈を省略します。

```gleam
pub fn main() {
  let count: Int = 1
}
```

### 文字列リテラル

Gleamでは、文字列はダブルクォーテーションで囲んで書きます。

```gleam
pub fn greeting() {
  "Hello, world!"
}
```

### コードのコメント

コメントを使うと、ソースコードを読む他のエンジニアに向けてメモを残せます。Gleamのコメントは、`//`で始まる1行のコメントです。

```gleam
pub fn main() {
  // This is a comment
  let x = 1
}
```

## Instructions

この演習では、お気に入りの料理本に載っている絶品ラザニアを作るために、コードをいくつか書いていきます。

ラザニア作りにかかる時間に関する、5つのタスクがあります。

## 1. オーブンに入れておく時間を分単位で定義する

引数を取らず、ラザニアをオーブンに入れておくべき時間を分で返す`expected_minutes_in_oven`関数を定義します。料理本によると、オーブンに入れておく時間は40分です。

```gleam
expected_minutes_in_oven()
// -> 40
```

## 2. オーブンに残り何分入れておくかを計算する

ラザニアを実際にオーブンに入れておいた時間を引数に取り、前のタスクで求めたオーブンに入れておく時間をもとに、あと何分オーブンに入れておく必要があるかを返す`remaining_minutes_in_oven`関数を定義します。

```gleam
remaining_minutes_in_oven(30)
// -> 10
```

## 3. 下準備にかかる時間を分単位で計算する

ラザニアに重ねた層の数を引数に取り、1層につき2分かかるものとして、下準備にかかった時間を分で返す`preparation_time_in_minutes`関数を定義します。

```gleam
preparation_time_in_minutes(2)
// -> 4
```

## 4. 作業時間の合計を分単位で計算する

`total_time_in_minutes`関数を定義します。この関数は2つの引数を取ります。1つ目の引数はラザニアに重ねた層の数、2つ目の引数はラザニアをオーブンに入れておいた時間（分）です。関数は、ラザニア作りに合計で何分かかったかを返すようにします。これは、下準備にかかった時間と、その時点でラザニアをオーブンに入れておいた時間を足したものです。

```gleam
total_time_in_minutes(3, 10)
// -> 16
```

## 5. ラザニアができたことを知らせる通知を作る

引数を取らず、ラザニアが食べごろになったことを知らせるメッセージを返す`alarm`関数を定義します。

```gleam
alarm()
// -> "Ding!"
```

## Source

### Created by

- @lpil