
// @nixzhu (zhuhongxu@gmail.com)

struct DPDA<State: Hashable> {

    var currentConfiguration: PDAConfiguration<State>?
    let acceptStates: Set<State>
    let ruleBook: DPDARuleBook<State>

    var accepting: Bool {
        guard let currentConfiguration = currentConfiguration else {
            return false
        }
        return acceptStates.contains(currentConfiguration.state)
    }

    private var stuck: Bool {
        return currentConfiguration == nil
    }

    mutating func readCharacter(_ character: Character) {
        guard let currentConfiguration = currentConfiguration else {
            return
        }
        if let _currentConfiguration = ruleBook.nextConfiguration(from: currentConfiguration, for: character) {
            self.currentConfiguration = ruleBook.followFreeMoves(for: _currentConfiguration)
        } else {
            self.currentConfiguration = nil
        }
    }

    mutating func readString(_ string: String) {
        for character in string.characters {
            readCharacter(character)
            if stuck {
                break
            }
        }
    }

    init(currentConfiguration: PDAConfiguration<State>, acceptStates: Set<State>, ruleBook: DPDARuleBook<State>) {
        self.currentConfiguration = ruleBook.followFreeMoves(for: currentConfiguration)
        self.acceptStates = acceptStates
        self.ruleBook = ruleBook
    }
}
