import gleam/result

pub fn with_retry(experiment: fn() -> Result(t, e)) -> Result(t, e) {
  case experiment() {
    Ok(result) -> Ok(result)
    Error(_e) -> experiment()
  }
}

pub fn record_timing(
  time_logger: fn() -> Nil,
  experiment: fn() -> Result(t, e),
) -> Result(t, e) {
  let _ = time_logger()
  case experiment() {
    Ok(result) -> {
      let _ = time_logger()
      Ok(result)
    }
    Error(error) -> {
      let _ = time_logger()
      Error(error)
    }
  }
}

pub fn run_experiment(
  name: String,
  setup: fn() -> Result(t, e),
  action: fn(t) -> Result(u, e),
  record: fn(t, u) -> Result(v, e),
) -> Result(#(String, v), e) {
  use setup_result <- result.try(setup())
  use action_result <- result.try(action(setup_result))
  case record(setup_result, action_result) {
    Ok(final) -> Ok(#(name, final))
    Error(error) -> Error(error)
  }
}
