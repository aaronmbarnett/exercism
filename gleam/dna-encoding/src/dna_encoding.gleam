import gleam/bit_array
import gleam/list

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  encode_recursive(dna, <<>>)
}

fn encode_recursive(dna: List(Nucleotide), acc: BitArray) -> BitArray {
  case dna {
    [first, ..rest] ->
      encode_recursive(rest, <<acc:bits, encode_nucleotide(first):2>>)
    [] -> acc
  }
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  decode_recursive(dna, [])
}

fn decode_recursive(
  dna: BitArray,
  acc: List(Nucleotide),
) -> Result(List(Nucleotide), Nil) {
  case dna {
    <<>> -> Ok(list.reverse(acc))
    <<nucleotide:2, rest:bits>> -> {
      case decode_nucleotide(nucleotide) {
        Error(Nil) -> Error(Nil)
        Ok(nuc) -> decode_recursive(rest, [nuc, ..acc])
      }
    }
    _ -> Error(Nil)
  }
}
