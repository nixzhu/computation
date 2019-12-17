// @nixzhu (zhuhongxu@gmail.com)

// 识别回文

let rules = [
  PDARule(state: 1, character: "a", nextState: 1, popCharacter: "$", pushCharacters: ["a", "$"]),
  PDARule(state: 1, character: "a", nextState: 1, popCharacter: "a", pushCharacters: ["a", "a"]),
  PDARule(state: 1, character: "a", nextState: 1, popCharacter: "b", pushCharacters: ["a", "b"]),
  PDARule(state: 1, character: "b", nextState: 1, popCharacter: "$", pushCharacters: ["b", "$"]),
  PDARule(state: 1, character: "b", nextState: 1, popCharacter: "a", pushCharacters: ["b", "a"]),
  PDARule(state: 1, character: "b", nextState: 1, popCharacter: "b", pushCharacters: ["b", "b"]),
  PDARule(state: 1, character: nil, nextState: 2, popCharacter: "$", pushCharacters: ["$"]),
  PDARule(state: 1, character: nil, nextState: 2, popCharacter: "a", pushCharacters: ["a"]),
  PDARule(state: 1, character: nil, nextState: 2, popCharacter: "b", pushCharacters: ["b"]),
  PDARule(state: 2, character: "a", nextState: 2, popCharacter: "a", pushCharacters: []),
  PDARule(state: 2, character: "b", nextState: 2, popCharacter: "b", pushCharacters: []),
  PDARule(state: 2, character: nil, nextState: 3, popCharacter: "$", pushCharacters: ["$"]),
]

let ruleBook = NPDARuleBook(rules: rules)

let npdaDesign = NPDADesign(
  startState: 1,
  bottomCharacter: "$",
  acceptStates: [3],
  ruleBook: ruleBook
)

print(npdaDesign.canAcceptsString("abba"))
print(npdaDesign.canAcceptsString("babbaabbab"))
print(npdaDesign.canAcceptsString("abb"))
print(npdaDesign.canAcceptsString("baabaa"))
