// @nixzhu (zhuhongxu@gmail.com)

struct NFA<State: Hashable> {
  var currentStates: Set<State>
  let acceptStates: Set<State>
  let ruleBook: NFARuleBook<State>

  var accepting: Bool {
    !acceptStates.isDisjoint(with: currentStates)
  }

  init(currentStates: Set<State>, acceptStates: Set<State>, ruleBook: NFARuleBook<State>) {
    self.currentStates = ruleBook.followFreeMoves(for: currentStates)
    self.acceptStates = acceptStates
    self.ruleBook = ruleBook
  }

  mutating func readCharacter(_ character: Character) {
    let _currentStates = ruleBook.nextStates(from: currentStates, for: character)
    currentStates = ruleBook.followFreeMoves(for: _currentStates)
  }

  mutating func readString(_ string: String) {
    string.forEach { readCharacter($0) }
  }
}
