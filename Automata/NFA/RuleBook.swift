
struct RuleBook<State: Hashable> {
    
    let rules: [Rule<State>]
    
    func nextStates(states states: Set<State>, character: Character) -> Set<State> {
        return Set(states.map({ followStatesFor(state: $0, character: character) }).flatMap({ $0 }))
    }
    
    private func followStatesFor(state state: State, character: Character) -> [State] {
        return rulesFor(state: state, character: character).map({ $0.followState })
    }
    
    private func rulesFor(state state: State, character: Character) -> [Rule<State>] {
        return rules.filter({ $0.canAppliesTo(state: state, character: character) })
    }
}
