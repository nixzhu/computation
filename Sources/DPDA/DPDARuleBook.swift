// @nixzhu (zhuhongxu@gmail.com)

struct DPDARuleBook<State: Hashable> {
  let rules: [PDARule<State>]

  func nextConfiguration(
    from configuration: PDAConfiguration<State>,
    for character: Character?
  ) -> PDAConfiguration<State>? {
    ruleFor(configuration: configuration, character: character)?
      .followConfiguration(from: configuration)
  }

  func canAppliesTo(configuration: PDAConfiguration<State>, character: Character?) -> Bool {
    ruleFor(configuration: configuration, character: character) != nil
  }

  func followFreeMoves(for configuration: PDAConfiguration<State>) -> PDAConfiguration<State> {
    if canAppliesTo(configuration: configuration, character: nil) {
      return followFreeMoves(for: nextConfiguration(from: configuration, for: nil)!)
    } else {
      return configuration
    }
  }

  private func ruleFor(
    configuration: PDAConfiguration<State>,
    character: Character?
  ) -> PDARule<State>? {
    rules.first(where: { $0.canAppliesTo(configuration: configuration, character: character) })
  }
}
