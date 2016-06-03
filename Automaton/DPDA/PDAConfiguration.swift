
// @nixzhu (zhuhongxu@gmail.com)

struct PDAConfiguration<State: Hashable> {

    let state: State
    let stack: Stack<Character>
}
