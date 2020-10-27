// @nixzhu (zhuhongxu@gmail.com)

struct Stack<Item: Hashable>: Hashable {
  private let items: [Item]

  var top: Item? {
    items.last
  }

  func push(_ item: Item) -> Stack<Item> {
    Stack(items + [item])
  }

  func pop() -> Stack<Item> {
    var _items = items
    _items.removeLast()

    return Stack(_items)
  }

  init(_ items: [Item]) {
    self.items = items
  }
}

extension Stack: CustomStringConvertible {
  var description: String {
    "|" + items.map({ "\($0)" }).joined(separator: "|")
  }
}
