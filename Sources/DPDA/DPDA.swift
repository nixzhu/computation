// @nixzhu (zhuhongxu@gmail.com)

struct DPDA<State: Hashable> {
  var currentConfiguration: PDAConfiguration<State>?
  let acceptStates: Set<State>
  let ruleBook: DPDARuleBook<State>

  var accepting: Bool {
    guard let configuration = currentConfiguration else {
      return false
    }
    return acceptStates.contains(configuration.state)
  }

  private var stuck: Bool {
    currentConfiguration == nil
  }

  init(
    currentConfiguration: PDAConfiguration<State>,
    acceptStates: Set<State>,
    ruleBook: DPDARuleBook<State>
  ) {
    self.currentConfiguration = ruleBook.followFreeMoves(for: currentConfiguration)
    self.acceptStates = acceptStates
    self.ruleBook = ruleBook
  }

  mutating func readCharacter(_ character: Character) {
    guard let configuration = currentConfiguration else {
      return
    }
    if let nextConfiguration = ruleBook.nextConfiguration(from: configuration, for: character) {
      currentConfiguration = ruleBook.followFreeMoves(for: nextConfiguration)
    } else {
      currentConfiguration = nil
    }
  }

  mutating func readString(_ string: String) {
    for character in string {
      readCharacter(character)

      if stuck {
        break
      }
    }
  }
}
