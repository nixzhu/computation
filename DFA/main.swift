
// xcrun swiftc *.swift -o testDFA && ./testDFA

let rules = [
    DFA.Rule(state: 1, character: "a", nextState: 2),
    DFA.Rule(state: 1, character: "b", nextState: 1),
    DFA.Rule(state: 2, character: "a", nextState: 2),
    DFA.Rule(state: 2, character: "b", nextState: 3),
    DFA.Rule(state: 3, character: "a", nextState: 3),
    DFA.Rule(state: 3, character: "b", nextState: 3),
]

let ruleBook = DFA.RuleBook(rules: rules)

["a", "baa", "baba"].forEach({
    let dfaDesign = DFADesign(startState: 1, acceptStates: [3], ruleBook: ruleBook)
    let can = dfaDesign.canAcceptsString($0)
    print("\($0)\t\(can)")
})
