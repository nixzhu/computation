// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "computation",
  products: [
    .executable(name: "dfa", targets: ["DFA"]),
    .executable(name: "nfa", targets: ["NFA"]),
    .executable(name: "re", targets: ["RE"]),
    .executable(name: "dpda", targets: ["DPDA"]),
    .executable(name: "npda", targets: ["NPDA"]),
    .executable(name: "tm", targets: ["TM"]),
  ],
  targets: [
    .target(name: "DFA"),
    .target(name: "NFA"),
    .target(name: "RE"),
    .target(name: "DPDA"),
    .target(name: "NPDA"),
    .target(name: "TM"),
  ]
)
