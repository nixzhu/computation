
// @nixzhu (zhuhongxu@gmail.com)

struct DFA<State: Hashable> {

    var currentState: State
    let acceptStates: Set<State>
    let ruleBook: DFARuleBook<State>

    var accepting: Bool {
        return acceptStates.contains(currentState)
    }

    mutating func readCharacter(character: Character) {
        if let state = ruleBook.nextState(state: currentState, character: character) {
            self.currentState = state
        } else {
            print("Invalid character: \(character)")
        }
    }

    mutating func readString(string: String) {
        string.characters.forEach({ readCharacter($0) })
    }
}
