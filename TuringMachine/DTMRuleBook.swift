
// @nixzhu (zhuhongxu@gmail.com)

struct DTMRuleBook<State: Hashable> {

    let rules: [TMRule<State>]

    func canAppliesTo(configuration configuration: TMConfiguration<State>) -> Bool {
        return ruleFor(configuration: configuration) != nil
    }

    func nextConfiguration(configuration configuration: TMConfiguration<State>) -> TMConfiguration<State>? {
        return ruleFor(configuration: configuration)?.followConfiguration(configuration: configuration)
    }

    private func ruleFor(configuration configuration: TMConfiguration<State>) -> TMRule<State>? {
        return rules.filter({ $0.canAppliesTo(configuration: configuration) }).first
    }
}
