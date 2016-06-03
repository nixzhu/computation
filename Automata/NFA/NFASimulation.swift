
// @nixzhu (zhuhongxu@gmail.com)

struct NFASimulation {

    let nfaDesign: NFADesign<Int>

    private func nextState(state state: Set<Int>, character: Character) -> Set<Int> {
        var nfa = nfaDesign.generatNFA(currentStates: state)
        nfa.readCharacter(character)
        return nfa.currentStates
    }

    private func rulesFor(state state: Set<Int>) -> [Rule<Set<Int>>] {
        return nfaDesign.ruleBook.alphabet.map({
            Rule(state: state, character: $0, nextState: nextState(state: state, character: $0))
        })
    }

    private func discoverStatesAndRules(states states: Set<Set<Int>>) -> (Set<Set<Int>>, [Rule<Set<Int>>]) {
        let rules = states.map({ rulesFor(state: $0) }).flatMap({ $0 })
        let moreStates = Set(rules.map({ $0.followState }))
        if moreStates.isSubsetOf(states) {
            return (states, rules)
        } else {
            return discoverStatesAndRules(states: states.union(moreStates))
        }
    }

    func generateDFADesign() -> DFADesign<Set<Int>> {
        let startState = nfaDesign.generatNFA().currentStates
        let (states, rules) = discoverStatesAndRules(states: [startState])
        let acceptStates = Set(states.filter({ nfaDesign.generatNFA(currentStates: $0).accepting }))
        return DFADesign<Set<Int>>(startState: startState, acceptStates: acceptStates, ruleBook: DFARuleBook(rules: rules))
    }
}
