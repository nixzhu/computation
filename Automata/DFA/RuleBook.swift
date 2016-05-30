
struct RuleBook<State: Hashable> {
        
    let rules: [Rule<State>]
    
    func nextState(state state: State, character: Character) -> State? {
            return ruleFor(state: state, character: character)?.follow
    }
    
    func ruleFor(state state: State, character: Character) -> Rule<State>? {
        return rules.filter({ $0.canAppliesTo(state: state, character: character) }).first
    }
}
