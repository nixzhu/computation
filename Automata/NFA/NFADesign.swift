
struct NFADesign<State: Hashable> {
    
    let startState: State
    let acceptStates: Set<State>
    let ruleBook: RuleBook<State>
    
    func generatNFA() -> NFA<State> {
        return NFA(currentStates: [startState], acceptStates: acceptStates, ruleBook: ruleBook)
    }
    
    func canAcceptsString(string: String) -> Bool {
        var nfa = generatNFA()
        nfa.readString(string)
        return nfa.accepting
    }
}
