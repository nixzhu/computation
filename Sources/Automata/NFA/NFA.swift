
// @nixzhu (zhuhongxu@gmail.com)

struct NFA<State: Hashable> {

    var currentStates: Set<State>
    let acceptStates: Set<State>
    let ruleBook: NFARuleBook<State>

    var accepting: Bool {
        return !acceptStates.isDisjoint(with: currentStates)
    }

    mutating func readCharacter(_ character: Character) {
        let _currentStates = ruleBook.nextStates(from: currentStates, for: character)
        self.currentStates = ruleBook.followFreeMoves(for: _currentStates)
    }

    mutating func readString(_ string: String) {
        string.characters.forEach({ readCharacter($0) })
    }

    init(currentStates: Set<State>, acceptStates: Set<State>, ruleBook: NFARuleBook<State>) {
        self.currentStates = ruleBook.followFreeMoves(for: currentStates)
        self.acceptStates = acceptStates
        self.ruleBook = ruleBook
    }
}
