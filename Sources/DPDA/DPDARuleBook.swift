
// @nixzhu (zhuhongxu@gmail.com)

struct DPDARuleBook<State: Hashable> {

    let rules: [PDARule<State>]

    func nextConfiguration(from configuration: PDAConfiguration<State>, for character: Character?) -> PDAConfiguration<State>? {
        return ruleFor(configuration: configuration, character: character)?.followConfiguration(from: configuration)
    }

    private func ruleFor(configuration: PDAConfiguration<State>, character: Character?) -> PDARule<State>? {
        return rules.filter({ $0.canAppliesTo(configuration: configuration, character: character) }).first
    }

    func canAppliesTo(configuration: PDAConfiguration<State>, character: Character?) -> Bool {
        return ruleFor(configuration: configuration, character: character) != nil
    }

    func followFreeMoves(for configuration: PDAConfiguration<State>) -> PDAConfiguration<State> {
        if canAppliesTo(configuration: configuration, character: nil) {
            return followFreeMoves(for: nextConfiguration(from: configuration, for: nil)!)
        } else {
            return configuration
        }
    }
}
