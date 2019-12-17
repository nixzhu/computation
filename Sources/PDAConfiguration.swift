// @nixzhu (zhuhongxu@gmail.com)

struct PDAConfiguration<State: Hashable>: Hashable {
  let state: State
  let stack: Stack<Character>
}
