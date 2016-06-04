
// @nixzhu (zhuhongxu@gmail.com)

struct NPDARuleBook<State: Hashable> {

    let rules: [PDARule<State>]

    func followFreeMoves(configurations configurations: Set<PDAConfiguration<State>>) -> Set<PDAConfiguration<State>> {
        let moreConfigurations = nextConfigurations(configurations: configurations, character: nil)
        if moreConfigurations.isSubsetOf(configurations) {
            return configurations
        } else {
            return followFreeMoves(configurations: configurations.union(moreConfigurations))
        }
    }

    func nextConfigurations(configurations configurations: Set<PDAConfiguration<State>>, character: Character?) -> Set<PDAConfiguration<State>> {
        return Set(configurations.map({ followConfigurationsFor(configuration: $0, character: character) }).flatMap({ $0 }))
    }

    func followConfigurationsFor(configuration configuration: PDAConfiguration<State>, character: Character?) -> [PDAConfiguration<State>] {
        return rulesFor(configuration: configuration, character: character).map({ $0.followConfiguration(configuration: configuration) })
    }

    private func rulesFor(configuration configuration: PDAConfiguration<State>, character: Character?) -> [PDARule<State>] {
        return rules.filter({ $0.canAppliesTo(configuration: configuration, character: character) })
    }
}
