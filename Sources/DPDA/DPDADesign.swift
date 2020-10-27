// @nixzhu (zhuhongxu@gmail.com)

struct DPDADesign<State: Hashable> {
  let startState: State
  let bottomCharacter: Character
  let acceptStates: Set<State>
  let ruleBook: DPDARuleBook<State>

  func canAcceptsString(_ string: String) -> Bool {
    var dpda = generateDPDA()
    dpda.readString(string)

    return dpda.accepting
  }

  func generateDPDA() -> DPDA<State> {
    let startStack = Stack([bottomCharacter])
    let startConfiguration = PDAConfiguration(state: startState, stack: startStack)
    return .init(
      currentConfiguration: startConfiguration,
      acceptStates: acceptStates,
      ruleBook: ruleBook
    )
  }
}
