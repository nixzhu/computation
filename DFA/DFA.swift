
typealias State = Int

struct DFA {
    
    struct Rule {
        
        let state: State
        let character: Character
        let nextState: State
        
        func canAppliesTo(state state: State, character: Character) -> Bool {
            return self.state == state && self.character == character    
        }
        
        var follow: State {
            return nextState
        }
    }
    
    struct RuleBook {
        
        let rules: [Rule]
        
        func nextState(state state: State, character: Character) -> State? {
              return ruleFor(state: state, character: character)?.follow
        }
        
        func ruleFor(state state: State, character: Character) -> Rule? {
            return rules.filter({ $0.canAppliesTo(state: state, character: character) }).first
        }
    }
    
    var currentState: State
    let acceptStates: Set<State>
    let ruleBook: RuleBook
    
    var accepting: Bool {
        return acceptStates.contains(currentState)
    }
    
    mutating func readCharacter(character: Character) {
        if let state = ruleBook.nextState(state: currentState, character: character) {
            self.currentState = state
        } else {
            print("Invalid character: \(character)")   
        }
    }
    
    mutating func readString(string: String) {
        string.characters.forEach({ readCharacter($0) })
    }
}

struct DFADesign {
    
    let startState: State
    let acceptStates: Set<State>
    let ruleBook: DFA.RuleBook
    
    func generatDFA() -> DFA {
         return DFA(currentState: startState, acceptStates: acceptStates, ruleBook: ruleBook)
    }
    
    func canAcceptsString(string: String) -> Bool {
        var dfa = generatDFA()
        dfa.readString(string)
        return dfa.accepting
    }
}
