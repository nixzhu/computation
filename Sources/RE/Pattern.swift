// @nixzhu (zhuhongxu@gmail.com)

enum Pattern {
  case empty
  case literal(character: Character)
  indirect case concatenate(firstPart: Pattern, secondPart: Pattern)
  indirect case choose(firstPart: Pattern, secondPart: Pattern)
  indirect case `repeat`(pattern: Pattern)

  var `precedence`: Int {
    switch self {
    case .empty: return 3
    case .literal: return 3
    case .concatenate: return 1
    case .choose: return 0
    case .repeat: return 2
    }
  }

  var string: String {
    switch self {
    case .empty:
      return ""
    case .literal(let character):
      return String(character)
    case .concatenate(let firstPart, let secondPart):
      return [firstPart, secondPart].map({ $0.bracket(`precedence`) }).joined(separator: "")
    case .choose(let firstPart, let secondPart):
      return [firstPart, secondPart].map({ $0.bracket(`precedence`) }).joined(separator: "|")
    case .repeat(let pattern):
      return pattern.bracket(`precedence`) + "*"
    }
  }

  var nfaDesign: NFADesign<Int> {
    switch self {
    case .empty:
      let startState = UniqueState.nextState()
      let acceptStates: Set<Int> = [startState]
      let ruleBook = NFARuleBook<Int>(rules: [])
      return .init(startState: startState, acceptStates: acceptStates, ruleBook: ruleBook)
    case .literal(let character):
      let startState = UniqueState.nextState()
      let acceptState = UniqueState.nextState()
      let rule = FARule(state: startState, character: character, nextState: acceptState)
      let ruleBook = NFARuleBook(rules: [rule])
      return .init(startState: startState, acceptStates: [acceptState], ruleBook: ruleBook)
    case .concatenate(let firstPart, let secondPart):
      let firstPartNFADesign = firstPart.nfaDesign
      let secondPartNFADesign = secondPart.nfaDesign
      let startState = firstPartNFADesign.startState
      let acceptStates = secondPartNFADesign.acceptStates
      let rules = firstPartNFADesign.ruleBook.rules + secondPartNFADesign.ruleBook.rules
      let extraRules = firstPartNFADesign.acceptStates.map({
        FARule(state: $0, character: nil, nextState: secondPartNFADesign.startState)
      })
      let ruleBook = NFARuleBook(rules: rules + extraRules)
      return .init(startState: startState, acceptStates: acceptStates, ruleBook: ruleBook)
    case .choose(let firstPart, let secondPart):
      let firstPartNFADesign = firstPart.nfaDesign
      let secondPartNFADesign = secondPart.nfaDesign
      let startState = UniqueState.nextState()
      let acceptStates = firstPartNFADesign.acceptStates.union(secondPartNFADesign.acceptStates)
      let rules = firstPartNFADesign.ruleBook.rules + secondPartNFADesign.ruleBook.rules
      let extraRules = [firstPartNFADesign, secondPartNFADesign].map {
        FARule(state: startState, character: nil, nextState: $0.startState)
      }
      let ruleBook = NFARuleBook(rules: rules + extraRules)
      return .init(startState: startState, acceptStates: acceptStates, ruleBook: ruleBook)
    case .repeat(let pattern):
      let patternNFADesign = pattern.nfaDesign
      let startState = UniqueState.nextState()
      let acceptStates = patternNFADesign.acceptStates.union([startState])
      let rules = patternNFADesign.ruleBook.rules
      let extraRules = patternNFADesign.acceptStates.map {
        FARule(state: $0, character: nil, nextState: patternNFADesign.startState)
      } + [FARule(state: startState, character: nil, nextState: patternNFADesign.startState)]
      let ruleBook = NFARuleBook(rules: rules + extraRules)
      return .init(startState: startState, acceptStates: acceptStates, ruleBook: ruleBook)
    }
  }

  private func bracket(_ outerPrecedence: Int) -> String {
    if `precedence` < outerPrecedence {
      return "(\(string))"
    } else {
      return string
    }
  }

  func canMatchesString(_ string: String) -> Bool {
    nfaDesign.canAcceptsString(string)
  }
}

private class UniqueState {
  static let shared = UniqueState()

  private var count = 0

  private init() {}

  static func nextState() -> Int {
    defer {
      shared.count += 1
    }
    return shared.count
  }
}
