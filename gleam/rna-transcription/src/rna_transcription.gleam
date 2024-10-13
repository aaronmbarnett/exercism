import gleam/string

pub fn to_rna(dna: String) -> Result(String, Nil) {
  to_rna_recursive(dna, "")
}

fn to_rna_recursive(dna: String, acc: String) -> Result(String, Nil) {
  case dna {
    "" -> Ok(acc)
    "A" <> rest -> to_rna_recursive(rest, string.append(acc, "U"))
    "T" <> rest -> to_rna_recursive(rest, string.append(acc, "A"))
    "C" <> rest -> to_rna_recursive(rest, string.append(acc, "G"))
    "G" <> rest -> to_rna_recursive(rest, string.append(acc, "C"))
    _ -> Error(Nil)
  }
}
