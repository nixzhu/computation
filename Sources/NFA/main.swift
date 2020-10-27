// @nixzhu (zhuhongxu@gmail.com)

do {
  //         a,b
  //        ┌───┐
  //        │   ▼
  //       ┌─────┐  b   ┌─────┐ a,b  ┌─────┐  a,b ╔═════╗
  // ─────▶│  1  │─────▶│  2  │─────▶│  3  │─────▶║  4  ║
  //       └─────┘      └─────┘      └─────┘      ╚═════╝

  print("Accepts string which the third-last character is `b`:")

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

  ["bab", "bbbbb", "bbabb"].forEach {
    let nfaDesign = NFADesign(startState: 1, acceptStates: [4], ruleBook: ruleBook)
    let result = nfaDesign.canAcceptsString($0)
    print("\($0)\t\(result)")
  }
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

  print("Accepts string which length is a multiple of two or three:")

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

  ["a", "aa", "aaa", "aaaa", "aaaaa", "aaaaaa"].forEach {
    let nfaDesign = NFADesign(startState: 1, acceptStates: [2, 4], ruleBook: ruleBook)
    let result = nfaDesign.canAcceptsString($0)
    print("\($0)\t\(result)")
  }
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

  print("Convert NFA to DFA:")

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

  ["aaa", "aab", "bbbabb"].forEach {
    let result = dfaDesign.canAcceptsString($0)
    print("\($0)\t\(result)")
  }
}
