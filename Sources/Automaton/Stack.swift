
// @nixzhu (zhuhongxu@gmail.com)

struct Stack<Item> {

    let contents: [Item]

    func push(_ item: Item) -> Stack<Item> {
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
}

extension Stack: CustomStringConvertible {

    var description: String {
        return contents.enumerated().map({ $0 == 0 ? "(\($1))" : "\($1)" }).joined(separator: "")
    }
}
