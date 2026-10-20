import gleam/result

pub fn with_retry(experiment: fn() -> Result(t, e)) -> Result(t, e) {
  let result = experiment()
  case result {
    Ok(_) -> result
    Error(_) -> experiment()
  }
}

pub fn record_timing(
  time_logger: fn() -> Nil,
  experiment: fn() -> Result(t, e),
) -> Result(t, e) {
  time_logger()
  let result = experiment()
  time_logger()
  result
}

pub fn run_experiment(
  name: String,
  setup: fn() -> Result(t, e),
  action: fn(t) -> Result(u, e),
  record: fn(t, u) -> Result(v, e),
) -> Result(#(String, v), e) {
  use t <- result.try(setup())
  use u <- result.try(action(t))
  use v <- result.try(record(t, u))
  Ok(#(name, v))
}

//  use t <- result.try(setup())
//  rest(t)
//  // コンパイラが次の形に書き換える
//  result.try(setup(), fn(t) { rest(t) })

pub fn run_experiment_with_no_use(
  name: String,
  setup: fn() -> Result(t, e),
  action: fn(t) -> Result(u, e),
  record: fn(t, u) -> Result(v, e),
) -> Result(#(String, v), e) {
  result.try(setup(), fn(t) {
    result.try(action(t), fn(u) {
      result.try(record(t, u), fn(v) { Ok(#(name, v)) })
    })
  })
}
