
// @nixzhu (zhuhongxu@gmail.com)

var configuration = PDAConfiguration(state: 1, stack: Stack(contents: ["$"]))

let rules = [
    PDARule(state: 1, character: "(", nextState: 2, popCharacter: "$", pushCharacters: ["b", "$"]),
    PDARule(state: 2, character: "(", nextState: 2, popCharacter: "b", pushCharacters: ["b", "b"]),
    PDARule(state: 2, character: ")", nextState: 2, popCharacter: "b", pushCharacters: []),
    PDARule(state: 2, character: nil, nextState: 1, popCharacter: "$", pushCharacters: ["$"]),
]
let ruleBook = DPDARuleBook(rules: rules)

configuration = ruleBook.nextConfiguration(configuration: configuration, character: "(")!
print(configuration)
configuration = ruleBook.nextConfiguration(configuration: configuration, character: "(")!
print(configuration)
configuration = ruleBook.nextConfiguration(configuration: configuration, character: ")")!
print(configuration)
