
// @nixzhu (zhuhongxu@gmail.com)

struct DTM<State: Hashable> {

    var currentConfiguration: TMConfiguration<State>?
    let acceptStates: Set<State>
    let ruleBook: DTMRuleBook<State>

    var accepting: Bool {
        guard let currentConfiguration = currentConfiguration else {
            return false
        }
        return acceptStates.contains(currentConfiguration.state)
    }

    var stuck: Bool {
        guard let currentConfiguration = currentConfiguration else {
            return true
        }
        return !accepting && !ruleBook.canAppliesTo(configuration: currentConfiguration)
    }

    mutating func step() {
        guard let currentConfiguration = currentConfiguration else {
            return
        }
        self.currentConfiguration = ruleBook.nextConfiguration(from: currentConfiguration)
    }

    mutating func run() {
        while !accepting && !stuck {
            step()
        }
    }
}
