
struct NFADesign {

    let startState: State
    let acceptStates: Set<State>
    let ruleBook: RuleBook

    func generatNFA() -> NFA {
        return NFA(currentStates: [startState], acceptStates: acceptStates, ruleBook: ruleBook)
    }

    func canAcceptsString(string: String) -> Bool {
        var nfa = generatNFA()
        nfa.readString(string)
        return nfa.accepting
    }
}
