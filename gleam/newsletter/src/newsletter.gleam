import exercism/test_runner.{debug}
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  let result = simplifile.read(path)
  case result {
    Ok(result) -> Ok(string.split(string.trim(result), "\n"))
    Error(_error) -> Error(Nil)
  }
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  case simplifile.create_file(path) {
    Ok(_result) -> Ok(Nil)
    Error(_error) -> Error(Nil)
  }
}

fn append(path: String, email: String) {
  case simplifile.append(path, email <> "\n") {
    Ok(_result) -> Ok(Nil)
    Error(_error) -> Error(Nil)
  }
}

fn write(path: String, email: String) {
  case simplifile.write(to: path, contents: email <> "\n") {
    Ok(_result) -> Ok(Nil)
    Error(_error) -> Error(Nil)
  }
}

fn handle_update_log(result_bool, path, email) {
  case result_bool {
    True -> append(path, email)
    False -> write(path, email)
  }
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  let result = simplifile.verify_is_file(path)
  case result {
    Ok(result_bool) ->
      case result_bool {
        True -> handle_update_log(result_bool, path, email)
        False ->
          result.try(create_log_file(path), fn(_a) {
            handle_update_log(result_bool, path, email)
          })
      }
    Error(_error) -> Error(Nil)
  }
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  result.try(create_log_file(log_path), fn(_a) {
    result.try(read_emails(emails_path), fn(emails) {
      list.try_each(emails, fn(email) {
        debug(email)
        case send_email(email) {
          Ok(_result) -> log_sent_email(log_path, email)
          Error(_err) -> Ok(Nil)
        }
      })
    })
  })
}
