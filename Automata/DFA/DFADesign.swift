
struct DFADesign<State: Hashable> {
    
    let startState: State
    let acceptStates: Set<State>
    let ruleBook: RuleBook<State>
    
    func generatDFA() -> DFA<State> {
         return DFA(currentState: startState, acceptStates: acceptStates, ruleBook: ruleBook)
    }
    
    func canAcceptsString(string: String) -> Bool {
        var dfa = generatDFA()
        dfa.readString(string)
        return dfa.accepting
    }
}
