
// xcrun swiftc *.swift ../Rule.swift -o testNFA && ./testNFA

do {

//         a,b
//        ┌───┐
//        │   ▼
//       ┌─────┐  b   ┌─────┐ a,b  ┌─────┐  a,b ╔═════╗
// ─────▶│  1  │─────▶│  2  │─────▶│  3  │─────▶║  4  ║
//       └─────┘      └─────┘      └─────┘      ╚═════╝

    print("accept string which the third-last character is 'b':")

    let rules = [
        Rule(state: 1, character: "a", nextState: 1),
        Rule(state: 1, character: "b", nextState: 1),
        Rule(state: 1, character: "b", nextState: 2),
        Rule(state: 2, character: "a", nextState: 3),
        Rule(state: 2, character: "b", nextState: 3),
        Rule(state: 3, character: "a", nextState: 4),
        Rule(state: 3, character: "b", nextState: 4),
    ]

    let ruleBook = RuleBook(rules: rules)

    ["bab", "bbbbb", "bbabb"].forEach({
        let nfaDesign = NFADesign(startState: 1, acceptStates: [4], ruleBook: ruleBook)
        let can = nfaDesign.canAcceptsString($0)
        print("\($0)\t\(can)")
    })
}

do {

//                               a
//                         ┌───────────┐
//                         │           ▼
//                     ┌─────┐      ┌─────┐
//                  ─ ▶│  2  │      │  3  │
//                 │   └─────┘      └─────┘
//                         ▲     a     │
//                 │       └───────────┘
//
//       ┌─────┐   │
// ─────▶│  1  │─ ─ ─       ┌─────┐    a    ┌─────┐
//       └─────┘     └ ─ ─ ▶│  4  │────────▶│  5  │
//                          └─────┘         └─────┘
//                             ▲               │
//                             │ a  ┌─────┐  a │
//                             └────│  6  │◀───┘
//                                  └─────┘

    print("accept string which length is a multiple of two or three:")

    let rules = [
        Rule(state: 1, character: nil, nextState: 2),
        Rule(state: 1, character: nil, nextState: 4),
        Rule(state: 2, character: "a", nextState: 3),
        Rule(state: 3, character: "a", nextState: 2),
        Rule(state: 4, character: "a", nextState: 5),
        Rule(state: 5, character: "a", nextState: 6),
        Rule(state: 6, character: "a", nextState: 4),
    ]

    let ruleBook = RuleBook(rules: rules)

    ["a", "aa", "aaa", "aaaa", "aaaaa", "aaaaaa"].forEach({
        let nfaDesign = NFADesign(startState: 1, acceptStates: [2, 4], ruleBook: ruleBook)
        let can = nfaDesign.canAcceptsString($0)
        print("\($0)\t\(can)")
    })
}

do {
    let rules = [
        Rule(state: 1, character: "a", nextState: 1),
        Rule(state: 1, character: "a", nextState: 2),
        Rule(state: 1, character: nil, nextState: 2),
        Rule(state: 2, character: "b", nextState: 3),
        Rule(state: 3, character: "b", nextState: 1),
        Rule(state: 3, character: nil, nextState: 2),
    ]

    let ruleBook = RuleBook(rules: rules)

    let nfaDesign = NFADesign(startState: 1, acceptStates: [3], ruleBook: ruleBook)

    print(nfaDesign.generatNFA().currentStates)
    print(nfaDesign.generatNFA(currentStates: [2]).currentStates)
    print(nfaDesign.generatNFA(currentStates: [3]).currentStates)

    var nfa = nfaDesign.generatNFA(currentStates: [2, 3])
    nfa.readCharacter("b")
    print(nfa.currentStates)

    let simulation = NFASimulation(nfaDesign: nfaDesign)
    print(simulation.nextStates(states: [1, 2], character: "a"))
    print(simulation.nextStates(states: [1, 2], character: "b"))
    print(simulation.nextStates(states: [3, 2], character: "b"))
    print(simulation.nextStates(states: [1, 3, 2], character: "b"))
    print(simulation.nextStates(states: [1, 3, 2], character: "a"))
}
