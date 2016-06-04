
// @nixzhu (zhuhongxu@gmail.com)

struct NPDA<State: Hashable> {

    var currentConfigurations: Set<PDAConfiguration<State>>
    let acceptStates: Set<State>
    let ruleBook: NPDARuleBook<State>

    var accepting: Bool {
        for configuration in currentConfigurations {
            if acceptStates.contains(configuration.state) {
                return true
            }
        }
        return false
    }

    mutating func readCharacter(character: Character) {
        let _currentConfigurations = ruleBook.nextConfigurations(configurations: currentConfigurations, character: character)
        self.currentConfigurations = ruleBook.followFreeMoves(configurations: _currentConfigurations)
    }

    mutating func readString(string: String) {
        string.characters.forEach({ readCharacter($0) })
    }

    init(currentConfigurations: Set<PDAConfiguration<State>>, acceptStates: Set<State>, ruleBook: NPDARuleBook<State>) {
        self.currentConfigurations = ruleBook.followFreeMoves(configurations: currentConfigurations)
        self.acceptStates = acceptStates
        self.ruleBook = ruleBook
    }
}
