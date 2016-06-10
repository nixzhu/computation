
// @nixzhu (zhuhongxu@gmail.com)

let tape = Tape(leftCharacters: ["1", "0", "1"], middleCharacter: "1", rightCharacters: [], blankCharacter: "_")
print(tape)
print(tape.moveHeadLeft())
print(tape.writeCharacter("0"))
print(tape.moveHeadRight())
print(tape.moveHeadRight().writeCharacter("0"))

let rule = TMRule(state: 1, character: "0", nextState: 2, writeCharacter: "1", direction: .Right)
print(rule)
print(rule.canAppliesTo(configuration: TMConfiguration(state: 1, tape: Tape(leftCharacters: [], middleCharacter: "0", rightCharacters: [], blankCharacter: "_"))))
print(rule.canAppliesTo(configuration: TMConfiguration(state: 1, tape: Tape(leftCharacters: [], middleCharacter: "1", rightCharacters: [], blankCharacter: "_"))))
print(rule.canAppliesTo(configuration: TMConfiguration(state: 2, tape: Tape(leftCharacters: [], middleCharacter: "0", rightCharacters: [], blankCharacter: "_"))))

print(rule.followConfiguration(configuration: TMConfiguration(state: 1, tape: Tape(leftCharacters: [], middleCharacter: "0", rightCharacters: [], blankCharacter: "_"))))

let rules = [
    TMRule(state: 1, character: "0", nextState: 2, writeCharacter: "1", direction: .Right),
    TMRule(state: 1, character: "1", nextState: 1, writeCharacter: "0", direction: .Left),
    TMRule(state: 1, character: "_", nextState: 2, writeCharacter: "1", direction: .Right),
    TMRule(state: 2, character: "0", nextState: 2, writeCharacter: "0", direction: .Right),
    TMRule(state: 2, character: "1", nextState: 2, writeCharacter: "1", direction: .Right),
    TMRule(state: 2, character: "_", nextState: 3, writeCharacter: "_", direction: .Left),
]
let ruleBook = DTMRuleBook(rules: rules)

var configuration = TMConfiguration(state: 1, tape: tape)
print(configuration)
configuration = ruleBook.nextConfiguration(configuration: configuration)!
print(configuration)
configuration = ruleBook.nextConfiguration(configuration: configuration)!
print(configuration)
configuration = ruleBook.nextConfiguration(configuration: configuration)!
print(configuration)
