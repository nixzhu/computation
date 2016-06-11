
// @nixzhu (zhuhongxu@gmail.com)

typealias P = () -> Void

let zero = { (p: P) in
    return { (x: Void) in
        return x
    }
}

print(zero)

let one = { (p: P) in
    return { (x: Void) in
        return p(x)
    }
}

print(one)

let two = { (p: P) in
    return { (x: Void) in
        return p(p(x))
    }
}

print(two)
