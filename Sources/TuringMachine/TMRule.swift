
// @nixzhu (zhuhongxu@gmail.com)

enum Direction {
    case Left
    case Right
}

struct TMRule<State: Hashable> {

    let state: State
    let character: Character
    let nextState: State
    let writeCharacter: Character
    let direction: Direction

    func canAppliesTo(configuration: TMConfiguration<State>) -> Bool {
        return (state == configuration.state) && (character == configuration.tape.middleCharacter)
    }

    func followConfiguration(from configuration: TMConfiguration<State>) -> TMConfiguration<State> {
        return TMConfiguration(state: nextState, tape: nextTape(for: configuration))
    }

    func nextTape(for configuration: TMConfiguration<State>) -> Tape {
        let writtenTape = configuration.tape.writeCharacter(writeCharacter)
        switch direction {
        case .Left:
            return writtenTape.moveHeadLeft()
        case .Right:
            return writtenTape.moveHeadRight()
        }
    }
}
