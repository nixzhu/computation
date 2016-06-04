
// @nixzhu (zhuhongxu@gmail.com)

func ==<State: Hashable>(lhs: PDAConfiguration<State>, rhs: PDAConfiguration<State>) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

struct PDAConfiguration<State: Hashable>: Hashable {

    let state: State
    let stack: Stack<Character>

    var hashValue: Int {
        return state.hashValue ^ stack.hashValue
    }
}
