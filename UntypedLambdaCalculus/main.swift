
// @nixzhu (zhuhongxu@gmail.com)

typealias P = Int -> Int

typealias INTEGER = P -> Int -> Int

let ZERO    : INTEGER = { p in { x in x } }
let ONE     : INTEGER = { p in { x in p(x) } }
let TWO     : INTEGER = { p in { x in p(p(x)) } }

func toInteger(integer: INTEGER) -> Int {
    return integer({ $0 + 1 })(0)
}

print(toInteger(ZERO))
print(toInteger(ONE))
print(toInteger(TWO))

typealias B = () -> Bool
typealias BOOLEAN = (B, B) -> B

let TRUE    : BOOLEAN = { t, f in t }
let FALSE   : BOOLEAN = { t, f in f }

func toBoolean(boolean: BOOLEAN) -> Bool {
    return boolean({ true }, { false })()
}

print(toBoolean(TRUE))
print(toBoolean(FALSE))
