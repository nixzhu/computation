
struct NFA<State: Hashable> {
    
    var currentStates: Set<State>
    let acceptStates: Set<State>
    let ruleBook: RuleBook<State>
    
    var accepting: Bool {
        return !acceptStates.isDisjointWith(currentStates)
    }
    
    mutating func readCharacter(character: Character) {
        self.currentStates = ruleBook.nextStates(states: currentStates, character: character)
    }
    
    mutating func readString(string: String) {
        string.characters.forEach({ readCharacter($0) })
    }
}
