
// @nixzhu (zhuhongxu@gmail.com)

struct DFARuleBook<State: Hashable> {

    let rules: [FARule<State>]

    func nextState(state state: State, character: Character) -> State? {
        return ruleFor(state: state, character: character)?.followState
    }

    private func ruleFor(state state: State, character: Character) -> FARule<State>? {
        return rules.filter({ $0.canAppliesTo(state: state, character: character) }).first
    }
}
