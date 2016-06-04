
// @nixzhu (zhuhongxu@gmail.com)

struct DPDARuleBook<State: Hashable> {

    let rules: [PDARule<State>]

    func nextConfiguration(configuration configuration: PDAConfiguration<State>, character: Character?) -> PDAConfiguration<State>? {
        return ruleFor(configuration: configuration, character: character)?.followConfiguration(configuration: configuration)
    }

    private func ruleFor(configuration configuration: PDAConfiguration<State>, character: Character?) -> PDARule<State>? {
        return rules.filter({ $0.canAppliesTo(configuration: configuration, character: character) }).first
    }

    func canAppliesTo(configuration configuration: PDAConfiguration<State>, character: Character?) -> Bool {
        return ruleFor(configuration: configuration, character: character) != nil
    }

    func followFreeMoves(configuration configuration: PDAConfiguration<State>) -> PDAConfiguration<State> {
        if canAppliesTo(configuration: configuration, character: nil) {
            return followFreeMoves(configuration: nextConfiguration(configuration: configuration, character: nil)!)
        } else {
            return configuration
        }
    }
}
