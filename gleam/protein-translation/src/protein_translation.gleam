import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string

pub fn proteins(rna: String) -> Result(List(String), Nil) {
  case string.length(rna) {
    0 -> Ok([])
    i if i < 3 -> Error(Nil)
    _ -> {
      let codon = string.slice(rna, 0, 3)
      let rest_of_rna_string = string.slice(rna, 3, string.length(rna))
      case codon_to_amino_acid(codon) {
        Error(Nil) -> Error(Nil)
        Ok(None) -> Ok([])
        Ok(Some(codon)) -> {
          case result.try(Ok(rest_of_rna_string), proteins) {
            Ok(result) -> Ok([codon, ..result])
            Error(Nil) -> Error(Nil)
          }
        }
      }
    }
  }
}

fn codon_to_amino_acid(codon: String) -> Result(Option(String), Nil) {
  case codon {
    "AUG" -> Ok(Some("Methionine"))
    "UUU" | "UUC" -> Ok(Some("Phenylalanine"))
    "UUA" | "UUG" -> Ok(Some("Leucine"))
    "UCU" | "UCC" | "UCA" | "UCG" -> Ok(Some("Serine"))
    "UAU" | "UAC" -> Ok(Some("Tyrosine"))
    "UGU" | "UGC" -> Ok(Some("Cysteine"))
    "UGG" -> Ok(Some("Tryptophan"))
    "UAA" | "UAG" | "UGA" -> Ok(None)
    _ -> Error(Nil)
  }
}
