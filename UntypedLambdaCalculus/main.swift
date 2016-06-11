
// @nixzhu (zhuhongxu@gmail.com)

typealias P = Int -> Int

let zero = { (p: P) in
    return { (x: Int) in
        return x
    }
}

let one = { (p: P) in
    return { (x: Int) in
        return p(x)
    }
}

let two = { (p: P) in
    return { (x: Int) in
        return p(p(x))
    }
}

let three = { (p: P) in
    return { (x: Int) in
        return p(p(p(x)))
    }
}

func toInteger(proc: P -> (Int -> Int)) -> Int {
    return proc({ $0 + 1 })(0)
}

print(toInteger(zero))
print(toInteger(one))
print(toInteger(two))
print(toInteger(three))
