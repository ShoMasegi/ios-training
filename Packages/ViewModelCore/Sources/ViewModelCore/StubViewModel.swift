import Combine

public final class StubViewModel<Argument, Action, State>: ViewModel {
    public let argument: Argument

    public var state: State {
        get { stateSubject.value }
        set { stateSubject.value = newValue }
    }

    public var statePublisher: AnyPublisher<State, Never> {
        stateSubject.eraseToAnyPublisher()
    }

    private let stateSubject: CurrentValueSubject<State, Never>

    public private(set) var actions: [Action] = []

    init(argument: Argument, state: State) {
        self.argument = argument
        stateSubject = .init(state)
    }

    public func send(action: Action) {
        actions.append(action)
    }
}

public extension ViewModel {
    typealias Stub = StubViewModel<Argument, Action, State>

    static func stub(argument: Argument, state: State) -> Stub {
        StubViewModel(argument: argument, state: state)
    }
}

public extension ViewModel where Argument == Void {
    static func stub(state: State) -> Stub {
        StubViewModel(argument: (), state: state)
    }
}
