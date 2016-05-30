
struct RuleBook {

    let rules: [Rule]

    func nextStates(states states: Set<State>, character: Character?) -> Set<State> {
        return Set(states.map({ followStatesFor(state: $0, character: character) }).flatMap({ $0 }))
    }

    private func followStatesFor(state state: State, character: Character?) -> [State] {
        return rulesFor(state: state, character: character).map({ $0.followState })
    }

    private func rulesFor(state state: State, character: Character?) -> [Rule] {
        return rules.filter({ $0.canAppliesTo(state: state, character: character) })
    }

    func followFreeMoves(states states: Set<State>) -> Set<State> {
        let moreStates = nextStates(states: states, character: nil)
        if moreStates.isSubsetOf(states) {
            return states
        } else {
            return followFreeMoves(states: states.union(moreStates))
        }
    }
}
