
// @nixzhu (zhuhongxu@gmail.com)

struct DPDADesign<State: Hashable> {

    let startState: State
    let bottomCharacter: Character
    let acceptStates: Set<State>
    let ruleBook: DPDARuleBook<State>

    func canAcceptsString(string: String) -> Bool {
        var dpda = generatDPDA()
        dpda.readString(string)
        return dpda.accepting
    }

    func generatDPDA() -> DPDA<State> {
        let startStack = Stack(contents: [bottomCharacter])
        let startConfiguration = PDAConfiguration(state: startState, stack: startStack)
        return DPDA(currentConfiguration: startConfiguration, acceptStates: acceptStates, ruleBook: ruleBook)
    }
}
