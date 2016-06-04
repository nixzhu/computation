
// @nixzhu (zhuhongxu@gmail.com)

let configuration = PDAConfiguration(state: 1, stack: Stack(contents: ["$"]))

let rules = [
    PDARule(state: 1, character: "(", nextState: 2, popCharacter: "$", pushCharacters: ["b", "$"]),
    PDARule(state: 2, character: "(", nextState: 2, popCharacter: "b", pushCharacters: ["b", "b"]),
    PDARule(state: 2, character: ")", nextState: 2, popCharacter: "b", pushCharacters: []),
    PDARule(state: 2, character: nil, nextState: 1, popCharacter: "$", pushCharacters: ["$"]),
]
let ruleBook = DPDARuleBook(rules: rules)

let dpdaDesign = DPDADesign(startState: 1, bottomCharacter: "$", acceptStates: [1], ruleBook: ruleBook)

print(dpdaDesign.canAcceptsString("(((((((((())))))))))"))
print(dpdaDesign.canAcceptsString("()(())((()))(()(()))"))
print(dpdaDesign.canAcceptsString("(()(()(()()(()()))()"))
