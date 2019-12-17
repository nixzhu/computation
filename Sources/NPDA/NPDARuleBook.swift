// @nixzhu (zhuhongxu@gmail.com)

struct NPDARuleBook<State: Hashable> {
  let rules: [PDARule<State>]

  func followFreeMoves(for configurations: Set<PDAConfiguration<State>>) -> Set<PDAConfiguration<State>> {
    let moreConfigurations = nextConfigurations(from: configurations, for: nil)
    if moreConfigurations.isSubset(of: configurations) {
      return configurations
    } else {
      return followFreeMoves(for: configurations.union(moreConfigurations))
    }
  }

  func nextConfigurations(
    from configurations: Set<PDAConfiguration<State>>,
    for character: Character?
  ) -> Set<PDAConfiguration<State>> {
    let nextConfigurations = configurations
      .flatMap { followConfigurationsFor(configuration: $0, character: character) }
    return .init(nextConfigurations)
  }

  func followConfigurationsFor(
    configuration: PDAConfiguration<State>,
    character: Character?
  ) -> [PDAConfiguration<State>] {
    rulesFor(configuration: configuration, character: character)
      .map { $0.followConfiguration(from: configuration) }
  }

  private func rulesFor(
    configuration: PDAConfiguration<State>,
    character: Character?
  ) -> [PDARule<State>] {
    rules.filter { $0.canAppliesTo(configuration: configuration, character: character) }
  }
}
