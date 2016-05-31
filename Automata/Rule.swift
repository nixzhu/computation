
public typealias State = Int

// public func ==(lhs: State, rhs: State) -> Bool {
//     return lhs.name == rhs.name
// }
// public struct State: Hashable {
//     let states: Set<Int>
//     public var hashValue : Int { return states.hashValue }
//
//     public init(state: Int) {
//         self.states = [state]
//     }
//
//     public init(states: Set<Int>) {
//         self.states = states
//     }
// }
//
// extension State: IntegerLiteralConvertible {
//
//     public init(integerLiteral state: Int) {
//         self.states = [state]
//         print("***")
//     }
// }
//
// extension State: ArrayLiteralConvertible {
//
//     public init(arrayLiteral states: Int...) {
//         self.states = Set(states)
//     }
// }

public struct Rule {

    let state: State
    let character: Character?
    let nextState: State

    public func canAppliesTo(state state: State, character: Character?) -> Bool {
        return self.state == state && self.character == character
    }

    public var followState: State {
        return nextState
    }

    public init(state: State, character: Character?, nextState: State) {
        self.state = state
        self.character = character
        self.nextState = nextState
    }
}
