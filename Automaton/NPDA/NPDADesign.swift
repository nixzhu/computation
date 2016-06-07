
// @nixzhu (zhuhongxu@gmail.com)

struct NPDADesign<State: Hashable> {

    let startState: State
    let bottomCharacter: Character
    let acceptStates: Set<State>
    let ruleBook: NPDARuleBook<State>

    func canAcceptsString(string: String) -> Bool {
        var npda = generateNPDA()
        npda.readString(string)
        return npda.accepting
    }

    func generateNPDA() -> NPDA<State> {
        let startStack = Stack(contents: [bottomCharacter])
        let startConfiguration = PDAConfiguration(state: startState, stack: startStack)
        return NPDA(currentConfigurations: [startConfiguration], acceptStates: acceptStates, ruleBook: ruleBook)
    }
}