
// @nixzhu (zhuhongxu@gmail.com)

struct NFASimulation {

    let nfaDesign: NFADesign<Int>

    private func nextState(from state: Set<Int>, for character: Character) -> Set<Int> {
        var nfa = nfaDesign.generateNFA(from: state)
        nfa.readCharacter(character)
        return nfa.currentStates
    }

    private func rulesFor(state: Set<Int>) -> [FARule<Set<Int>>] {
        return nfaDesign.ruleBook.alphabet.map({
            FARule(state: state, character: $0, nextState: nextState(from: state, for: $0))
        })
    }

    private func discoverStatesAndRules(for states: Set<Set<Int>>) -> (Set<Set<Int>>, [FARule<Set<Int>>]) {
        let rules = states.map({ rulesFor(state: $0) }).flatMap({ $0 })
        let moreStates = Set(rules.map({ $0.followState }))
        if moreStates.isSubset(of: states) {
            return (states, rules)
        } else {
            return discoverStatesAndRules(for: states.union(moreStates))
        }
    }

    func generateDFADesign() -> DFADesign<Set<Int>> {
        let startState = nfaDesign.generateNFA().currentStates
        let (states, rules) = discoverStatesAndRules(for: [startState])
        let acceptStates = Set(states.filter({ nfaDesign.generateNFA(from: $0).accepting }))
        return DFADesign<Set<Int>>(startState: startState, acceptStates: acceptStates, ruleBook: DFARuleBook(rules: rules))
    }
}
