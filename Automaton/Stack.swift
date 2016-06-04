
// @nixzhu (zhuhongxu@gmail.com)

func ==<Item: Hashable>(lhs: Stack<Item>, rhs: Stack<Item>) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

struct Stack<Item: Hashable>: Hashable {

    let contents: [Item]

    func push(item: Item) -> Stack<Item> {
        return Stack(contents: [item] + contents)
    }

    func pop() -> Stack<Item> {
        var _contents = contents
        _contents.removeFirst()
        return Stack(contents: _contents)
    }

    var top: Item? {
        return contents.first
    }

    init(contents: [Item]) {
        self.contents = contents
    }

    var hashValue: Int {
        return contents.reduce(0, combine: { $0.hashValue ^ $1.hashValue })
    }
}

extension Stack: CustomStringConvertible {

    var description: String {
        return contents.enumerate().map({ $0 == 0 ? "(\($1))" : "\($1)" }).joinWithSeparator("")
    }
}
