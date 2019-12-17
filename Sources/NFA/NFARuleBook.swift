// @nixzhu (zhuhongxu@gmail.com)

struct NFARuleBook<State: Hashable> {
  let rules: [FARule<State>]

  var alphabet: [Character] {
    Array(Set(rules.compactMap { $0.character }))
  }

  func nextStates(from states: Set<State>, for character: Character?) -> Set<State> {
    Set(states.map({ followStatesFor(state: $0, character: character) }).flatMap({ $0 }))
  }

  private func followStatesFor(state: State, character: Character?) -> [State] {
    rulesFor(state: state, character: character).map { $0.followState }
  }

  private func rulesFor(state: State, character: Character?) -> [FARule<State>] {
    rules.filter { $0.canAppliesTo(state: state, character: character) }
  }

  func followFreeMoves(for states: Set<State>) -> Set<State> {
    let moreStates = nextStates(from: states, for: nil)
    if moreStates.isSubset(of: states) {
      return states
    } else {
      return followFreeMoves(for: states.union(moreStates))
    }
  }
}
