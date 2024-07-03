import gleam/string

pub fn first_letter(name: String) -> String {
  string.trim(name) |> string.slice(0, 1)
}

pub fn initial(name: String) {
  name
  |> first_letter
  |> string.uppercase
  |> string.append(".")
}

pub fn initials(full_name: String) -> String {
  let split_name = string.split(full_name, " ")
  case split_name {
    [first, last] -> initial(first) <> " " <> initial(last)
    _ -> ""
  }
}

pub fn pair(full_name1: String, full_name2: String) {
  let heart =
    "
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     $. ^.  +  #. &.     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
  string.replace(heart, "$. ^.", initials(full_name1))
  |> string.replace("#. &.", initials(full_name2))
}
