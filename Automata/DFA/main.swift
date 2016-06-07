
// @nixzhu (zhuhongxu@gmail.com)

// xcrun swiftc *.swift ../FARule.swift -o testDFA && ./testDFA

//          b            a           a,b
//        ┌───┐        ┌───┐        ┌───┐
//        │   ▼        │   ▼        │   ▼
//       ┌─────┐  a   ┌─────┐  b   ╔═════╗
// ─────▶│  1  │─────▶│  2  │─────▶║  3  ║
//       └─────┘      └─────┘      ╚═════╝

print("accepts string which contains \"ab\":")

let rules = [
    FARule(state: 1, character: "a", nextState: 2),
    FARule(state: 1, character: "b", nextState: 1),
    FARule(state: 2, character: "a", nextState: 2),
    FARule(state: 2, character: "b", nextState: 3),
    FARule(state: 3, character: "a", nextState: 3),
    FARule(state: 3, character: "b", nextState: 3),
]

let ruleBook = DFARuleBook(rules: rules)

["a", "baa", "baba"].forEach({
    let dfaDesign = DFADesign(startState: 1, acceptStates: [3], ruleBook: ruleBook)
    let can = dfaDesign.canAcceptsString($0)
    print("\($0)\t\(can)")
})
