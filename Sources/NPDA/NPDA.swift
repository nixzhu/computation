// @nixzhu (zhuhongxu@gmail.com)

struct NPDA<State: Hashable> {
  var currentConfigurations: Set<PDAConfiguration<State>>
  let acceptStates: Set<State>
  let ruleBook: NPDARuleBook<State>

  var accepting: Bool {
    for configuration in currentConfigurations {
      if acceptStates.contains(configuration.state) {
        return true
      }
    }
    return false
  }

  init(
    currentConfigurations: Set<PDAConfiguration<State>>,
    acceptStates: Set<State>,
    ruleBook: NPDARuleBook<State>
  ) {
    self.currentConfigurations = ruleBook.followFreeMoves(for: currentConfigurations)
    self.acceptStates = acceptStates
    self.ruleBook = ruleBook
  }

  mutating func readCharacter(_ character: Character) {
    let configurations = ruleBook.nextConfigurations(from: currentConfigurations, for: character)
    currentConfigurations = ruleBook.followFreeMoves(for: configurations)
  }

  mutating func readString(_ string: String) {
    string.forEach { readCharacter($0) }
  }
}
