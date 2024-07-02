import gleam/list

pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  let #(string, num) = place_location
  #(num, string)
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  let #(pl_string, pl_num) = place_location
  #(pl_num, pl_string) == treasure_location
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  list.fold(treasures, 0, fn(acc, treasure) {
    let #(_, treasure_coords) = treasure
    case treasure_location_matches_place_location(place.1, treasure_coords) {
      True -> acc + 1
      False -> acc
    }
  })
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  let #(treasure_name, _) = found_treasure
  let #(place_name, _) = place
  let #(desired_treasure_name, _) = desired_treasure
  case treasure_name {
    "Brass Spyglass" ->
      case place_name {
        "Abandoned Lighthouse" -> True
        _ -> False
      }
    "Amethyst Octopus" ->
      case place_name {
        "Stormy Breakwater" ->
          case desired_treasure_name {
            "Crystal Crab" -> True
            "Glass Starfish" -> True
            _ -> False
          }
        _ -> False
      }
    "Vintage Pirate Hat" ->
      case place_name {
        "Harbor Managers Office" ->
          case desired_treasure_name {
            "Model Ship in Large Bottle" -> True
            "Antique Glass Fishnet Float" -> True
            _ -> False
          }
        _ -> False
      }
    _ -> False
  }
}
// pub fn special_case_swap_possible(
//   found_treasure: #(String, #(Int, String)),
//   place: #(String, #(String, Int)),
//   desired_treasure: #(String, #(Int, String)),
// ) -> Bool {
//   case found_treasure.0, place.0, desired_treasure.0 {
//     "Amethyst Octopus", "Stormy Breakwater", "Crystal Crab" -> True
//     "Amethyst Octopus", "Stormy Breakwater", "Glass Starfish" -> True
//     "Vintage Pirate Hat", "Harbor Managers Office", "Model Ship in Large Bottle"
//     -> True
//     "Vintage Pirate Hat",
//       "Harbor Managers Office",
//       "Antique Glass Fishnet Float"
//     -> True
//     "Brass Spyglass", "Abandoned Lighthouse", _ -> True
//     _, _, _ -> False
//   }
// }
