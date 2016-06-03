
// @nixzhu (zhuhongxu@gmail.com)

struct DPDARuleBook<State: Hashable> {

    let rules: [PDARule<State>]

    func nextConfiguration(configuration configuration: PDAConfiguration<State>, character: Character) -> PDAConfiguration<State>? {
        return ruleFor(configuration: configuration, character: character)?.followConfiguration(configuration: configuration)
    }

    private func ruleFor(configuration configuration: PDAConfiguration<State>, character: Character) -> PDARule<State>? {
        return rules.filter({ $0.canAppliesTo(configuration: configuration, character: character) }).first
    }
}
