
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
