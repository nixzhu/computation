
// @nixzhu (zhuhongxu@gmail.com)

import Foundation

private func uniqueState() -> Int {
    return NSUUID().UUIDString.hashValue
}

enum Pattern {
    case Empty
    case Literal(character: Character)
    indirect case Concatenate(firstPart: Pattern, secondPart: Pattern)
    indirect case Choose(firstPart: Pattern, secondPart: Pattern)
    indirect case Repeat(pattern: Pattern)

    var `precedence`: Int {
        switch self {
        case .Empty: return 3
        case .Literal: return 3
        case .Concatenate: return 1
        case .Choose: return 0
        case .Repeat: return 2
        }
    }

    var string: String {
        switch self {
        case .Empty:
            return ""
        case .Literal(let character):
            return String(character)
        case .Concatenate(let firstPart, let secondPart):
            return [firstPart, secondPart].map({ $0.bracket(`precedence`) }).joinWithSeparator("")
        case .Choose(let firstPart, let secondPart):
            return [firstPart, secondPart].map({ $0.bracket(`precedence`) }).joinWithSeparator("|")
        case .Repeat(let pattern):
            return pattern.bracket(`precedence`) + "*"
        }
    }

    private func bracket(outerPrecedence: Int) -> String {
        if `precedence` < outerPrecedence {
            return "(\(string))"
        } else {
            return string
        }
    }

    var nfaDesign: NFADesign<Int> {
        switch self {
        case .Empty:
            let startState = uniqueState()
            let acceptStates: Set<Int> = [startState]
            let ruleBook = NFARuleBook<Int>(rules: [])
            return NFADesign(startState: startState, acceptStates: acceptStates, ruleBook: ruleBook)
        case .Literal(let character):
            let startState = uniqueState()
            let acceptState = uniqueState()
            let rule = Rule(state: startState, character: character, nextState: acceptState)
            let ruleBook = NFARuleBook(rules: [rule])
            return NFADesign(startState: startState, acceptStates: [acceptState], ruleBook: ruleBook)
        case .Concatenate(let firstPart, let secondPart):
            let firstPartNFADesign = firstPart.nfaDesign
            let secondPartNFADesign = secondPart.nfaDesign
            let startState = firstPartNFADesign.startState
            let acceptStates = secondPartNFADesign.acceptStates
            let rules = firstPartNFADesign.ruleBook.rules + secondPartNFADesign.ruleBook.rules
            let extraRules = firstPartNFADesign.acceptStates.map({
                Rule(state: $0, character: nil, nextState: secondPartNFADesign.startState)
            })
            let ruleBook = NFARuleBook(rules: rules + extraRules)
            return NFADesign(startState: startState, acceptStates: acceptStates, ruleBook: ruleBook)
        case .Choose(let firstPart, let secondPart):
            let firstPartNFADesign = firstPart.nfaDesign
            let secondPartNFADesign = secondPart.nfaDesign
            let startState = uniqueState()
            let acceptStates = firstPartNFADesign.acceptStates.union(secondPartNFADesign.acceptStates)
            let rules = firstPartNFADesign.ruleBook.rules + secondPartNFADesign.ruleBook.rules
            let extraRules = [firstPartNFADesign, secondPartNFADesign].map({
                Rule(state: startState, character: nil, nextState: $0.startState)
            })
            let ruleBook = NFARuleBook(rules: rules + extraRules)
            return NFADesign(startState: startState, acceptStates: acceptStates, ruleBook: ruleBook)
        case .Repeat(let pattern):
            let patternNFADesign = pattern.nfaDesign
            let startState = uniqueState()
            let acceptStates = patternNFADesign.acceptStates.union([startState])
            let rules = patternNFADesign.ruleBook.rules
            let extraRules = patternNFADesign.acceptStates.map({
                Rule(state: $0, character: nil, nextState: patternNFADesign.startState)
            }) + [Rule(state: startState, character: nil, nextState: patternNFADesign.startState)]
            let ruleBook = NFARuleBook(rules: rules + extraRules)
            return NFADesign(startState: startState, acceptStates: acceptStates, ruleBook: ruleBook)
        }
    }

    func canMatchesString(string: String) -> Bool {
        return nfaDesign.canAcceptsString(string)
    }
}
