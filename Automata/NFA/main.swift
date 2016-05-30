
// xcrun swiftc *.swift ../Rule.swift -o testNFA && ./testNFA

//         a,b                                         
//        ┌───┐                                        
//        │   ▼                                        
//       ┌─────┐  b   ┌─────┐ a,b  ┌─────┐  a,b ╔═════╗
// ─────▶│  1  │─────▶│  2  │─────▶│  3  │─────▶║  4  ║
//       └─────┘      └─────┘      └─────┘      ╚═════╝

// accept string the third-last character is 'b'

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
