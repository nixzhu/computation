
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

    func canAppliesTo(configuration configuration: TMConfiguration<State>) -> Bool {
        return (state == configuration.state) && (character == configuration.tape.middleCharacter)
    }
}
