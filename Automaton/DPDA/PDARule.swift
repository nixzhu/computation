
// @nixzhu (zhuhongxu@gmail.com)

struct PDARule<State: Hashable> {

    let state: State
    let character: Character?
    let nextState: State
    let popCharacter: Character
    let pushCharacters: [Character]

    func canAppliesTo(configuration configuration: PDAConfiguration<State>, character: Character?) -> Bool {
        return self.state == configuration.state &&
            self.popCharacter == configuration.stack.top &&
            self.character == character
    }

    func followConfiguration(configuration configuration: PDAConfiguration<State>) -> PDAConfiguration<State> {
        return PDAConfiguration(state: nextState, stack: nextStack(configuration: configuration))
    }

    private func nextStack(configuration configuration: PDAConfiguration<State>) -> Stack<Character> {
        let poppedStack = configuration.stack.pop()
        return pushCharacters.reverse().reduce(poppedStack, combine: { $0.push($1) })
    }
}
