
// @nixzhu (zhuhongxu@gmail.com)

// xcrun swiftc *.swift ../FARule.swift ../DFA/DFA.swift ../DFA/DFADesign.swift ../DFA/DFARuleBook.swift -o testNFA && ./testNFA

do {
    //         a,b
    //        ┌───┐
    //        │   ▼
    //       ┌─────┐  b   ┌─────┐ a,b  ┌─────┐  a,b ╔═════╗
    // ─────▶│  1  │─────▶│  2  │─────▶│  3  │─────▶║  4  ║
    //       └─────┘      └─────┘      └─────┘      ╚═════╝

    print("accept string which the third-last character is 'b':")

    let rules = [
        FARule(state: 1, character: "a", nextState: 1),
        FARule(state: 1, character: "b", nextState: 1),
        FARule(state: 1, character: "b", nextState: 2),
        FARule(state: 2, character: "a", nextState: 3),
        FARule(state: 2, character: "b", nextState: 3),
        FARule(state: 3, character: "a", nextState: 4),
        FARule(state: 3, character: "b", nextState: 4),
    ]

    let ruleBook = NFARuleBook(rules: rules)

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
        FARule(state: 1, character: nil, nextState: 2),
        FARule(state: 1, character: nil, nextState: 4),
        FARule(state: 2, character: "a", nextState: 3),
        FARule(state: 3, character: "a", nextState: 2),
        FARule(state: 4, character: "a", nextState: 5),
        FARule(state: 5, character: "a", nextState: 6),
        FARule(state: 6, character: "a", nextState: 4),
    ]

    let ruleBook = NFARuleBook(rules: rules)

    ["a", "aa", "aaa", "aaaa", "aaaaa", "aaaaaa"].forEach({
        let nfaDesign = NFADesign(startState: 1, acceptStates: [2, 4], ruleBook: ruleBook)
        let can = nfaDesign.canAcceptsString($0)
        print("\($0)\t\(can)")
    })
}

do {
    //            a
    //          ┌───┐
    //          │   ▼       a                   b
    //         ┌─────┐────────────▶┌─────┐────────────▶╔═════╗
    // ───────▶│  1  │             │  2  │             ║  3  ║
    //         └─────┘─ ─ ─ ─ ─ ─ ▶└─────┘◀ ─ ─ ─ ─ ─ ─╚═════╝
    //            ▲                                       │
    //            │                   b                   │
    //            └───────────────────────────────────────┘

    print("convert NFA to DFA:")

    let rules = [
        FARule(state: 1, character: "a", nextState: 1),
        FARule(state: 1, character: "a", nextState: 2),
        FARule(state: 1, character: nil, nextState: 2),
        FARule(state: 2, character: "b", nextState: 3),
        FARule(state: 3, character: "b", nextState: 1),
        FARule(state: 3, character: nil, nextState: 2),
    ]

    let ruleBook = NFARuleBook(rules: rules)

    let nfaDesign = NFADesign(startState: 1, acceptStates: [3], ruleBook: ruleBook)

    let simulation = NFASimulation(nfaDesign: nfaDesign)

    let dfaDesign = simulation.generateDFADesign()

    ["aaa", "aab", "bbbabb"].forEach({
        let can = dfaDesign.canAcceptsString($0)
        print("\($0)\t\(can)")
    })
}
