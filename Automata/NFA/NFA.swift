
struct NFA {

    var currentStates: Set<State>
    let acceptStates: Set<State>
    let ruleBook: RuleBook

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

    init(currentStates: Set<State>, acceptStates: Set<State>, ruleBook: RuleBook) {
        self.currentStates = ruleBook.followFreeMoves(states: currentStates)
        self.acceptStates = acceptStates
        self.ruleBook = ruleBook
    }
}
