// @nixzhu (zhuhongxu@gmail.com)

// Recognize string "aaabbbccc"

let tape = Tape(
  leftCharacters: [],
  middleCharacter: "a",
  rightCharacters: ["a", "a", "b", "b", "b", "c", "c", "c"],
  blankCharacter: "_"
)

let configuration = TMConfiguration(state: 1, tape: tape)

let rules = [
  // 状态 1: 向右扫描，查找 a
  TMRule(state: 1, character: "X", nextState: 1, writeCharacter: "X", direction: .right),
  TMRule(state: 1, character: "a", nextState: 2, writeCharacter: "X", direction: .right),
  TMRule(state: 1, character: "_", nextState: 6, writeCharacter: "_", direction: .left),

  // 状态 2: 向右扫描，查找 b
  TMRule(state: 2, character: "a", nextState: 2, writeCharacter: "a", direction: .right),
  TMRule(state: 2, character: "X", nextState: 2, writeCharacter: "X", direction: .right),
  TMRule(state: 2, character: "b", nextState: 3, writeCharacter: "X", direction: .right),

  // 状态 3: 向右扫描，查找 c
  TMRule(state: 3, character: "b", nextState: 3, writeCharacter: "b", direction: .right),
  TMRule(state: 3, character: "X", nextState: 3, writeCharacter: "X", direction: .right),
  TMRule(state: 3, character: "c", nextState: 4, writeCharacter: "X", direction: .right),

  // 状态 4: 向右扫描，查找字符串结束标记
  TMRule(state: 4, character: "c", nextState: 4, writeCharacter: "c", direction: .right),
  TMRule(state: 4, character: "_", nextState: 5, writeCharacter: "_", direction: .left),

  // 状态 5: 向左扫描，查找字符串开始标记
  TMRule(state: 5, character: "a", nextState: 5, writeCharacter: "a", direction: .left),
  TMRule(state: 5, character: "b", nextState: 5, writeCharacter: "b", direction: .left),
  TMRule(state: 5, character: "c", nextState: 5, writeCharacter: "c", direction: .left),
  TMRule(state: 5, character: "X", nextState: 5, writeCharacter: "X", direction: .left),
  TMRule(state: 5, character: "_", nextState: 1, writeCharacter: "_", direction: .right),
]

let ruleBook = DTMRuleBook(rules: rules)

var dtm = DTM(currentConfiguration: configuration, acceptStates: [6], ruleBook: ruleBook)

(0..<10).forEach { _ in
  dtm.step()
}
print(dtm.currentConfiguration!)
print(dtm.accepting)

(0..<25).forEach { _ in
  dtm.step()
}
print(dtm.currentConfiguration!)
print(dtm.accepting)

dtm.run()
print(dtm.currentConfiguration!)
print(dtm.accepting)
