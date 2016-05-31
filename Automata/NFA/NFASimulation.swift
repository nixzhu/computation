
struct NFASimulation {

    let nfaDesign: NFADesign

    func nextState(state state: Set<State>, character: Character) -> Set<State> {
        var nfa = nfaDesign.generatNFA(currentStates: state)
        nfa.readCharacter(character)
        return nfa.currentStates
    }

    func rulesFor(state state: Set<State>) -> [Rule] {
        return nfaDesign.ruleBook.alphabet.map({
            Rule(state: state.hashValue, character: $0, nextState: nextState(state: state, character: $0).hashValue)
        })
    }
}
