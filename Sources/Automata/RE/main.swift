
// @nixzhu (zhuhongxu@gmail.com)

// xcrun swiftc *.swift ../NFA/NFA.swift ../NFA/NFADesign.swift ../NFA/NFARuleBook.swift ../FARule.swift -o testRE && ./testRE

let pattern = Pattern.repeat(pattern:
    Pattern.concatenate(
        firstPart: Pattern.literal(character: "a"),
        secondPart: Pattern.choose(
            firstPart: Pattern.empty,
            secondPart: Pattern.literal(character: "b")
        )
    )
)

print(pattern.string)

["", "a", "ab", "aba", "abab", "abaab", "abba"].forEach({
    print("\($0)\t\(pattern.canMatchesString($0))")
})
