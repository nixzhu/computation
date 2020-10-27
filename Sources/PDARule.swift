// @nixzhu (zhuhongxu@gmail.com)

struct PDARule<State: Hashable> {
  let state: State
  let character: Character?
  let nextState: State
  let popCharacter: Character
  let pushCharacters: [Character]

  func canAppliesTo(configuration: PDAConfiguration<State>, character: Character?) -> Bool {
    self.state == configuration.state
      && self.popCharacter == configuration.stack.top
      && self.character == character
  }

  func followConfiguration(from configuration: PDAConfiguration<State>) -> PDAConfiguration<State> {
    .init(state: nextState, stack: nextStack(for: configuration))
  }

  private func nextStack(for configuration: PDAConfiguration<State>) -> Stack<Character> {
    let poppedStack = configuration.stack.pop()
    return pushCharacters.reversed().reduce(poppedStack, { $0.push($1) })
  }
}
