// @nixzhu (zhuhongxu@gmail.com)

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

["", "a", "ab", "aba", "abab", "abaab", "abba"].forEach {
  print("\($0)\t\(pattern.canMatchesString($0))")
}
