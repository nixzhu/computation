// @nixzhu (zhuhongxu@gmail.com)

struct FARule<State: Hashable> {
  let state: State
  let character: Character?
  let nextState: State

  var followState: State {
    nextState
  }

  func canAppliesTo(state: State, character: Character?) -> Bool {
    self.state == state && self.character == character
  }
}
