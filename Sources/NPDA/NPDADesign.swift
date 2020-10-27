// @nixzhu (zhuhongxu@gmail.com)

struct NPDADesign<State: Hashable> {
  let startState: State
  let bottomCharacter: Character
  let acceptStates: Set<State>
  let ruleBook: NPDARuleBook<State>

  func canAcceptsString(_ string: String) -> Bool {
    var npda = generateNPDA()
    npda.readString(string)

    return npda.accepting
  }

  func generateNPDA() -> NPDA<State> {
    let startStack = Stack([bottomCharacter])
    let startConfiguration = PDAConfiguration(state: startState, stack: startStack)
    return .init(
      currentConfigurations: [startConfiguration],
      acceptStates: acceptStates,
      ruleBook: ruleBook
    )
  }
}
