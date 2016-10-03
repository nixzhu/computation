
// @nixzhu (zhuhongxu@gmail.com)

struct DTMRuleBook<State: Hashable> {

    let rules: [TMRule<State>]

    func canAppliesTo(configuration: TMConfiguration<State>) -> Bool {
        return ruleFor(configuration: configuration) != nil
    }

    func nextConfiguration(from configuration: TMConfiguration<State>) -> TMConfiguration<State>? {
        return ruleFor(configuration: configuration)?.followConfiguration(from: configuration)
    }

    private func ruleFor(configuration: TMConfiguration<State>) -> TMRule<State>? {
        return rules.filter({ $0.canAppliesTo(configuration: configuration) }).first
    }
}
