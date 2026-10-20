# Hints

## 1. `with_retry`関数を定義する

- `case`式を使うと、結果に対してパターンマッチングができます。

## 2. `record_timing`関数を定義する

- `experiment`関数が`Error`値を返す場合でも、`time_logger`関数を呼び出す必要があります。

## 3. `run_experiment`関数を定義する

- [`result.try`関数][result-try]は、`use`式の中で使うと、結果が`Error`値のときに処理を止められます。

[result-try]: https://hexdocs.pm/gleam_stdlib/gleam/result.html#try