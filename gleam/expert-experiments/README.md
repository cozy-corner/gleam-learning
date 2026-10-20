# エキスパートの実験

ExercismのGleamトラックのエキスパートの実験へようこそ。
テストの実行やコードの提出について助けが必要な場合は、`HELP.md`を確認してください。
演習で行き詰まったら、`HINTS.md`を確認してください。でも、まずはそれを使わずに解いてみましょう :)

## Introduction

## `use`式を使う

Gleamでは、高階関数、つまり他の関数を引数として受け取る関数を書いて使うことがよくあります。多くの高階関数を一度に使うと、インデントの階層が何層にもなってコードが読みにくくなることがあります。

たとえば、`Result(Int, Nil)`を返す複数の関数を呼び出し、4つすべてが成功したらそれらの値を合計する関数があります。

```gleam
import gleam/result

pub fn main() -> Result(Int, Nil) {
  result.try(function1(), fn(a) {
    result.try(function2(), fn(b) {
      result.try(function3(), fn(c) {
        result.try(function4(), fn(d) {
          Ok(a + b + c + d)
        })
      })
    })
  })
}
```

Gleamの`use`式を使えば、このコードをインデントなしで書くことができ、多くの場合読みやすくなります。

```gleam
import gleam/result

pub fn main() -> Result(Int, Nil) {
  use a <- result.try(function1())
  use b <- result.try(function2())
  use c <- result.try(function3())
  use d <- result.try(function4())
  Ok(a + b + c + d)
}
```

`use`式は、ブロック内の後続の文をすべてまとめ、それらをコールバック関数として関数呼び出しの最後の引数に渡します。`use`キーワードと`<-`記号の間にある変数は、コールバック関数に渡される引数の名前です。

```gleam
// This use expression
use a <- function(1, 2)
io.println("Hello!")
a

// Is equivalent to this normal function call
function(1, 2, fn(a) {
  io.println("Hello!")
  a
})
```

コールバック関数は、引数をいくつでも受け取れますし、まったく受け取らないこともできます。

```gleam
use a, b, c, d <- call_4_function()

use <- call_0_function()
```

`use`式で呼び出せる関数を作るために特別な要件はありません。最後の引数としてコールバック関数を受け取ることだけです。

```gleam
pub fn call_twice(function: fn() -> t) -> #(t, t) {
  let first = function()
  let second = function()
  #(first, second)
}
```

Gleamの`use`式は非常に強力な機能で、多くの問題に応用できますが、使いすぎるとコードが読みにくくなることがあります。通常の関数呼び出し構文を使い、コードが読みやすくなるときだけ`use`式に頼るのが一般的に好まれます。

## Instructions

Daphneは、自分の実験を実行して結果を記録するシステムに取り組んでいます。コードの一部が少し冗長で繰り返しが多くなってきたので、Daphneは、それを整理するために`use`式をいくつか書いてほしいと頼んできました。

## 1. `with_retry`関数を定義する

実験は、ちょっとした一度きりのミスで失敗することがあります。そこで、実験が失敗したときは、2回目はうまくいくかどうかを確かめるためにもう一度やり直したいとDaphneは考えています。

結果を返す関数を引数に取る`with_retry`関数を定義します。

関数が`Ok`値を返したら、`with_retry`はその値を返します。

関数が`Error`値を返したら、`with_retry`はもう一度その関数を呼び出し、その呼び出しの結果を返します。

Daphneはこの関数を次のように使います。

```gleam
pub fn main() {
  use <- with_retry
  // Perform the experiment here
}
```

## 2. `record_timing`関数を定義する

Daphneは、各実験の前後で時間を記録する関数を呼び出すことで、実験の実行にかかった時間を記録しています。

2つの引数を取る`record_timing`関数を定義します。
- 引数を取らず、`Nil`を返す時間記録用の関数。
- 引数を取らず、結果を返す実験用の関数。

`record_timing`は、時間を記録する関数を呼び出し、次に実験用の関数を呼び出し、さらに時間を記録する関数をもう一度呼び出して、最後に実験用の関数の結果を返します。

Daphneはこの関数を次のように使います。

```gleam
pub fn main() {
  use <- record_timing(time_logger)
  // Perform the experiment here
}
```

## 3. `run_experiment`関数を定義する

実験は3つのフェーズで構成されます。セットアップ、アクション、そして記録です。3つのフェーズはすべて結果を返し、それぞれのフェーズは、前のフェーズが成功した結果を必要とします。

4つの引数を取る`run_experiment`関数を定義します。
- 実験の名前（`String`）。
- 引数を取らず、結果を返すセットアップ関数。
- セットアップ関数の`Ok`値を引数に取り、結果を返すアクション関数。
- セットアップ関数とアクション関数の`Ok`値を引数に取り、結果を返す記録関数。

3つの関数がすべて成功したら、`run_experiment`は`Ok(#(experiment_name, recording_data))`を返します。

いずれかの関数が`Error`値を返したら、`run_experiment`はその値を返します。

Daphneはこの関数を次のように使います。

```gleam
pub fn main() {
  use setup_data, action_data <- run_experiment("Test 1", setup, action)
  // Record the results here
}
```

## Source

### Created by

- @lpil