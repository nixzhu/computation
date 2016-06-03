
// @nixzhu (zhuhongxu@gmail.com)

struct DFADesign<State: Hashable> {

    let startState: State
    let acceptStates: Set<State>
    let ruleBook: DFARuleBook<State>

    func generatDFA() -> DFA<State> {
         return DFA(currentState: startState, acceptStates: acceptStates, ruleBook: ruleBook)
    }

    func canAcceptsString(string: String) -> Bool {
        var dfa = generatDFA()
        dfa.readString(string)
        return dfa.accepting
    }
}
