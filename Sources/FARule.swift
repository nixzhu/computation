// @nixzhu (zhuhongxu@gmail.com)

public struct FARule<State: Hashable> {
  let state: State
  let character: Character?
  let nextState: State

  public func canAppliesTo(state: State, character: Character?) -> Bool {
    self.state == state && self.character == character
  }

  public var followState: State {
    nextState
  }

  public init(state: State, character: Character?, nextState: State) {
    self.state = state
    self.character = character
    self.nextState = nextState
  }
}
