
struct DFADesign {

    let startState: State
    let acceptStates: Set<State>
    let ruleBook: RuleBook

    func generatDFA() -> DFA {
         return DFA(currentState: startState, acceptStates: acceptStates, ruleBook: ruleBook)
    }

    func canAcceptsString(string: String) -> Bool {
        var dfa = generatDFA()
        dfa.readString(string)
        return dfa.accepting
    }
}
