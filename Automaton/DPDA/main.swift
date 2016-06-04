
// @nixzhu (zhuhongxu@gmail.com)

let configuration = PDAConfiguration(state: 1, stack: Stack(contents: ["$"]))

let rules = [
    PDARule(state: 1, character: "(", nextState: 2, popCharacter: "$", pushCharacters: ["b", "$"]),
    PDARule(state: 2, character: "(", nextState: 2, popCharacter: "b", pushCharacters: ["b", "b"]),
    PDARule(state: 2, character: ")", nextState: 2, popCharacter: "b", pushCharacters: []),
    PDARule(state: 2, character: nil, nextState: 1, popCharacter: "$", pushCharacters: ["$"]),
    PDARule(state: 1, character: nil, nextState: 1, popCharacter: "$", pushCharacters: ["$"]),
]
let ruleBook = DPDARuleBook(rules: rules)

var dpda = DPDA(currentConfiguration: configuration, acceptStates: [1], ruleBook: ruleBook)

print(dpda.accepting)
dpda.readString("(()")
print(dpda.accepting)
print(dpda.currentConfiguration)

do {
    let configuration = PDAConfiguration(state: 2, stack: Stack(contents: ["$"]))
    print(ruleBook.followFreeMoves(configuration: configuration))
}

do { // infinite loop
    let rules = [
        PDARule(state: 1, character: nil, nextState: 1, popCharacter: "$", pushCharacters: ["$"]),
    ]
    let ruleBook = DPDARuleBook(rules: rules)
    print(ruleBook.followFreeMoves(configuration: configuration))
}
