
struct RuleBook {

    let rules: [Rule]

    func nextState(state state: State, character: Character) -> State? {
        return ruleFor(state: state, character: character)?.followState
    }

    private func ruleFor(state state: State, character: Character) -> Rule? {
        return rules.filter({ $0.canAppliesTo(state: state, character: character) }).first
    }
}
