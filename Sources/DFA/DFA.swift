
// @nixzhu (zhuhongxu@gmail.com)

struct DFA<State: Hashable> {

    var currentState: State
    let acceptStates: Set<State>
    let ruleBook: DFARuleBook<State>

    var accepting: Bool {
        return acceptStates.contains(currentState)
    }

    mutating func readCharacter(_ character: Character) {
        if let state = ruleBook.nextState(from: currentState, for: character) {
            self.currentState = state
        } else {
            print("Invalid character: \(character)")
        }
    }

    mutating func readString(_ string: String) {
        string.characters.forEach({ readCharacter($0) })
    }
}
