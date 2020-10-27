// @nixzhu (zhuhongxu@gmail.com)

struct DFARuleBook<State: Hashable> {
  let rules: [FARule<State>]

  func nextState(from state: State, for character: Character) -> State? {
    ruleFor(state: state, character: character)?.followState
  }

  private func ruleFor(state: State, character: Character) -> FARule<State>? {
    rules.first(where: { $0.canAppliesTo(state: state, character: character) })
  }
}
