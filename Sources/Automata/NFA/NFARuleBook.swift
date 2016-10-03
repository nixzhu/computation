
// @nixzhu (zhuhongxu@gmail.com)

struct NFARuleBook<State: Hashable> {

    let rules: [FARule<State>]

    var alphabet: [Character] {
        return Array(Set(rules.map({ $0.character }).flatMap({ $0 })))
    }

    func nextStates(from states: Set<State>, for character: Character?) -> Set<State> {
        return Set(states.map({ followStatesFor(state: $0, character: character) }).flatMap({ $0 }))
    }

    private func followStatesFor(state: State, character: Character?) -> [State] {
        return rulesFor(state: state, character: character).map({ $0.followState })
    }

    private func rulesFor(state: State, character: Character?) -> [FARule<State>] {
        return rules.filter({ $0.canAppliesTo(state: state, character: character) })
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
