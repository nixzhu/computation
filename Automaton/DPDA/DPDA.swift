
// @nixzhu (zhuhongxu@gmail.com)

struct DPDA<State: Hashable> {

    var currentConfiguration: PDAConfiguration<State>
    let acceptStates: Set<State>
    let ruleBook: DPDARuleBook<State>

    var accepting: Bool {
        return acceptStates.contains(currentConfiguration.state)
    }

    mutating func readCharacter(character: Character) {
        self.currentConfiguration = ruleBook.nextConfiguration(configuration: currentConfiguration, character: character)!
    }

    mutating func readString(string: String) {
        string.characters.forEach({ readCharacter($0) })
    }
}
