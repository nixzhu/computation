
// @nixzhu (zhuhongxu@gmail.com)

let tape = Tape(leftCharacters: ["1", "0", "1"], middleCharacter: "1", rightCharacters: [], blankCharacter: "_")
let configuration = TMConfiguration(state: 1, tape: tape)

let rules = [
    TMRule(state: 1, character: "0", nextState: 2, writeCharacter: "1", direction: .Right),
    TMRule(state: 1, character: "1", nextState: 1, writeCharacter: "0", direction: .Left),
    TMRule(state: 1, character: "_", nextState: 2, writeCharacter: "1", direction: .Right),
    TMRule(state: 2, character: "0", nextState: 2, writeCharacter: "0", direction: .Right),
    TMRule(state: 2, character: "1", nextState: 2, writeCharacter: "1", direction: .Right),
    TMRule(state: 2, character: "_", nextState: 3, writeCharacter: "_", direction: .Left),
]
let ruleBook = DTMRuleBook(rules: rules)

var dtm = DTM(currentConfiguration: configuration, acceptStates: [3], ruleBook: ruleBook)
print(dtm.currentConfiguration)
print(dtm.accepting)
dtm.step()
print(dtm.currentConfiguration)
print(dtm.accepting)
dtm.run()
print(dtm.currentConfiguration)
print(dtm.accepting)
