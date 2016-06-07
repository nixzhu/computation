
// @nixzhu (zhuhongxu@gmail.com)

let tape = Tape(leftCharacters: ["1", "0", "1"], middleCharacter: "1", rightCharacters: [], blankCharacter: "_")
print(tape)
print(tape.moveHeadLeft())
print(tape.writeCharacter("0"))
print(tape.moveHeadRight())
print(tape.moveHeadRight().writeCharacter("0"))
