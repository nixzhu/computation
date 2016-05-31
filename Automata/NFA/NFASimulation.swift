
struct NFASimulation {

    let nfaDesign: NFADesign

    func nextStates(states states: Set<State>, character: Character) -> Set<State> {
        var nfa = nfaDesign.generatNFA(currentStates: states)
        nfa.readCharacter(character)
        return nfa.currentStates
    }
}
