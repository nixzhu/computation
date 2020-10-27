// @nixzhu (zhuhongxu@gmail.com)

struct NFADesign<State: Hashable> {
  let startState: State
  let acceptStates: Set<State>
  let ruleBook: NFARuleBook<State>

  func generateNFA(from currentStates: Set<State>? = nil) -> NFA<State> {
    .init(
      currentStates: currentStates ?? [startState],
      acceptStates: acceptStates,
      ruleBook: ruleBook
    )
  }

  func canAcceptsString(_ string: String) -> Bool {
    var nfa = generateNFA()
    nfa.readString(string)

    return nfa.accepting
  }
}
