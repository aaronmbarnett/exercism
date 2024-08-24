import gleam/result
import gleam/string

pub fn extract_error(problem: Result(a, b)) -> b {
  let assert Error(error) = problem
  error
}

pub fn remove_team_prefix(team: String) -> String {
  let assert "Team " <> prefix = team
  prefix
}

pub fn split_region_and_team(combined: String) -> #(String, String) {
  let result = string.split(combined, ",")

  let assert [first, "Team " <> second, ..] = result
  #(first, second)
}
