
// @nixzhu (zhuhongxu@gmail.com)

struct DPDA<State: Hashable> {

    var currentConfiguration: PDAConfiguration<State>
    let acceptStates: Set<State>
    let ruleBook: DPDARuleBook<State>

    var accepting: Bool {
        return acceptStates.contains(currentConfiguration.state)
    }

    mutating func readCharacter(character: Character) {
        let _currentConfiguration = ruleBook.nextConfiguration(configuration: currentConfiguration, character: character)!
        self.currentConfiguration = ruleBook.followFreeMoves(configuration: _currentConfiguration)
    }

    mutating func readString(string: String) {
        string.characters.forEach({ readCharacter($0) })
    }

    init(currentConfiguration: PDAConfiguration<State>, acceptStates: Set<State>, ruleBook: DPDARuleBook<State>) {
        self.currentConfiguration = ruleBook.followFreeMoves(configuration: currentConfiguration)
        self.acceptStates = acceptStates
        self.ruleBook = ruleBook
    }
}
