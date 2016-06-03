
// @nixzhu (zhuhongxu@gmail.com)

struct NFA<State: Hashable> {

    var currentStates: Set<State>
    let acceptStates: Set<State>
    let ruleBook: NFARuleBook<State>

    var accepting: Bool {
        return !acceptStates.isDisjointWith(currentStates)
    }

    mutating func readCharacter(character: Character) {
        let _currentStates = ruleBook.nextStates(states: currentStates, character: character)
        self.currentStates = ruleBook.followFreeMoves(states: _currentStates)
    }

    mutating func readString(string: String) {
        string.characters.forEach({ readCharacter($0) })
    }

    init(currentStates: Set<State>, acceptStates: Set<State>, ruleBook: NFARuleBook<State>) {
        self.currentStates = ruleBook.followFreeMoves(states: currentStates)
        self.acceptStates = acceptStates
        self.ruleBook = ruleBook
    }
}
