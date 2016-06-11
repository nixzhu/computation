
// @nixzhu (zhuhongxu@gmail.com)

typealias P = Int -> Int
typealias Number = P -> Int -> Int

let zero    : Number = { p in { x in x } }
let one     : Number = { p in { x in p(x) } }
let two     : Number = { p in { x in p(p(x)) } }
let three   : Number = { p in { x in p(p(p(x))) } }

func toInteger(number: Number) -> Int {
    return number({ $0 + 1 })(0)
}

print(toInteger(zero))
print(toInteger(one))
print(toInteger(two))
print(toInteger(three))
