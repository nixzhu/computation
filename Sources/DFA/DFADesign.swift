// @nixzhu (zhuhongxu@gmail.com)

struct DFADesign<State: Hashable> {
  let startState: State
  let acceptStates: Set<State>
  let ruleBook: DFARuleBook<State>

  func generatDFA() -> DFA<State> {
    .init(currentState: startState, acceptStates: acceptStates, ruleBook: ruleBook)
  }

  func canAcceptsString(_ string: String) -> Bool {
    var dfa = generatDFA()
    dfa.readString(string)
    return dfa.accepting
  }
}
