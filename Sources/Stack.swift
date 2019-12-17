// @nixzhu (zhuhongxu@gmail.com)

struct Stack<Item: Hashable>: Hashable {
  let contents: [Item]

  func push(_ item: Item) -> Stack<Item> {
    Stack(contents: [item] + contents)
  }

  func pop() -> Stack<Item> {
    var _contents = contents
    _contents.removeFirst()
    return Stack(contents: _contents)
  }

  var top: Item? {
    contents.first
  }

  init(contents: [Item]) {
    self.contents = contents
  }
}

extension Stack: CustomStringConvertible {
  var description: String {
    contents.enumerated().map({ $0 == 0 ? "(\($1))" : "\($1)" }).joined(separator: "")
  }
}
