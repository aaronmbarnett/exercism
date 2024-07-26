import gleam/string

// Please define the TreasureChest type
pub opaque type TreasureChest(treasure) {
  TreasureChest(treasure: treasure, password: String)
}

pub fn create(
  password: String,
  contents: treasure,
) -> Result(TreasureChest(treasure), String) {
  let pw_length = string.length(password)
  case pw_length >= 8 {
    True -> Ok(TreasureChest(contents, password))
    False -> Error("Password must be at least 8 characters long")
  }
}

pub fn open(
  chest: TreasureChest(treasure),
  password: String,
) -> Result(treasure, String) {
  case chest.password == password {
    True -> Ok(chest.treasure)
    False -> Error("Incorrect password")
  }
}
