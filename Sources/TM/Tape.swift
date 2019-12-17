// @nixzhu (zhuhongxu@gmail.com)

struct Tape {
  let leftCharacters: [Character]
  let middleCharacter: Character
  let rightCharacters: [Character]
  let blankCharacter: Character

  func writeCharacter(_ character: Character) -> Tape {
    .init(
      leftCharacters: leftCharacters,
      middleCharacter: character,
      rightCharacters: rightCharacters,
      blankCharacter: blankCharacter
    )
  }

  func moveHeadLeft() -> Tape {
    var _leftCharacters = leftCharacters
    let leftLast: Character? = _leftCharacters.isEmpty ? nil : _leftCharacters.removeLast()
    return .init(
      leftCharacters: _leftCharacters,
      middleCharacter: leftLast ?? blankCharacter,
      rightCharacters: [middleCharacter] + rightCharacters,
      blankCharacter: blankCharacter
    )
  }

  func moveHeadRight() -> Tape {
    var _rightCharacters = rightCharacters
    let rightFirst: Character? = _rightCharacters.isEmpty ? nil : _rightCharacters.removeFirst()
    return .init(
      leftCharacters: leftCharacters + [middleCharacter],
      middleCharacter: rightFirst ?? blankCharacter,
      rightCharacters: _rightCharacters,
      blankCharacter: blankCharacter
    )
  }
}

extension Tape: CustomStringConvertible {
  var description: String {
    "Tape: "
      + leftCharacters.map({ "\($0)" }).joined(separator: "")
      + "(\(middleCharacter))"
      + rightCharacters.map({ "\($0)" }).joined(separator: "")
  }
}
