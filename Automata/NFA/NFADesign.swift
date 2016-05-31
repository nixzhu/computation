
struct NFADesign {

    let startState: State
    let acceptStates: Set<State>
    let ruleBook: RuleBook

    func generatNFA(currentStates currentStates: Set<State>? = nil) -> NFA {
        let currentStates = currentStates ?? [startState]
        return NFA(currentStates: currentStates, acceptStates: acceptStates, ruleBook: ruleBook)
    }

    func canAcceptsString(string: String) -> Bool {
        var nfa = generatNFA()
        nfa.readString(string)
        return nfa.accepting
    }
}
