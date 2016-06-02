
// xcrun swiftc *.swift ../NFA/NFA.swift ../NFA/NFADesign.swift ../NFA/NFARuleBook.swift ../Rule.swift -o testRE && ./testRE

let pattern = Pattern.Repeat(pattern:
    Pattern.Concatenate(
        firstPart: Pattern.Literal(character: "a"),
        secondPart: Pattern.Choose(
            firstPart: Pattern.Empty,
            secondPart: Pattern.Literal(character: "b")
        )
    )
)

print(pattern.string)

["", "a", "ab", "aba", "abab", "abaab", "abba"].forEach({
    print("\($0)\t\(pattern.canMatchesString($0))")
})
