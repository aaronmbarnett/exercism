import gleam/option.{type Option, None, Some}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  case player.name {
    Some(name) -> name
    None -> "Mighty Magician"
  }
}

fn calc_mana_for_revive(player: Player) -> Option(Player) {
  case player.level {
    i if i > 9 ->
      Some(
        Player(
          ..player,
          health: 100,
          mana: case player.mana {
            Some(_mana) -> Some(100)
            None -> None
          },
        ),
      )
    _ -> Some(Player(..player, health: 100))
  }
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health <= 0 {
    True -> calc_mana_for_revive(player)
    False -> None
  }
}

fn calc_health_from_failed_cast(health: Int, mana_cost: Int) -> Int {
  case health - mana_cost {
    i if i < 0 -> 0
    _ -> health - mana_cost
  }
}

fn calc_outcome_of_cast(player: Player, mana: Int, cost: Int) {
  case mana - cost {
    i if i < 0 -> #(player, 0)
    _ -> #(Player(..player, mana: Some(mana - cost)), cost * 2)
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    Some(mana) -> calc_outcome_of_cast(player, mana, cost)
    None -> #(
      Player(
        ..player,
        health: calc_health_from_failed_cast(player.health, cost),
      ),
      0,
    )
  }
}
