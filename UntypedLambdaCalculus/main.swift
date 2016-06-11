
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

typealias B = Void -> Bool
typealias BOOLEAN = B -> B -> B

let TRUE    : BOOLEAN = { t in { f in t } }
let FALSE   : BOOLEAN = { t in { f in f } }

func toBoolean(boolean: BOOLEAN) -> Bool {
    return boolean({ true })({ false })()
}

print(toBoolean(TRUE))
print(toBoolean(FALSE))

typealias V = Void -> Void

let IF: BOOLEAN -> V -> V -> Void = { b in
    return { x in
        return { y in
            b({ x(); return true })({ y(); return false })()
            return
        }
    }
}

IF(TRUE)({ print("hello") })({ print("world") })
IF(FALSE)({ print("hello") })({ print("world") })
