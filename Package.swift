// swift-tools-version:5.3

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
    .target(
      name: "DFA",
      exclude: ["DFA.monopic"]
    ),
    .target(
      name: "NFA",
      exclude: [
        "NFA.monopic",
        "NFASimulation.monopic",
        "freeMoveNFA.monopic",
      ]
    ),
    .target(name: "RE"),
    .target(name: "DPDA"),
    .target(name: "NPDA"),
    .target(name: "TM"),
  ]
)
