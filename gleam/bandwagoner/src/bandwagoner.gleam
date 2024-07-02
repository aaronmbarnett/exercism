// TODO: please define the 'Coach' type
pub type Coach {
  Coach(name: String, former_player: Bool)
}

// TODO: please define the 'Stats' type
pub type Stats {
  Stats(wins: Int, losses: Int)
}

// TODO: please define the 'Team' type
pub type Team {
  Team(name: String, coach: Coach, stats: Stats)
}

pub fn create_coach(name: String, former_player: Bool) -> Coach {
  Coach(name, former_player)
}

pub fn create_stats(wins: Int, losses: Int) -> Stats {
  Stats(wins, losses)
}

pub fn create_team(name: String, coach: Coach, stats: Stats) -> Team {
  Team(name, coach, stats)
}

pub fn replace_coach(team: Team, coach: Coach) -> Team {
  case team {
    Team(name: n, coach: _, stats: s) -> Team(n, coach, s)
  }
}

pub fn is_same_team(home_team: Team, away_team: Team) -> Bool {
  home_team == away_team
}

pub fn root_for_team(team: Team) -> Bool {
  let more_losses_than_wins = team.stats.losses > team.stats.wins
  let more_than_59_wins = team.stats.wins > 59
  case
    team.coach.name,
    team.coach.former_player,
    team.name,
    more_than_59_wins,
    more_losses_than_wins
  {
    "Gregg Popovich", _, _, _, _ -> True
    _, True, _, _, _ -> True
    _, _, "Chicago Bulls", _, _ -> True
    _, _, _, True, _ -> True
    _, _, _, _, True -> True
    _, _, _, _, _ -> False
  }
}
