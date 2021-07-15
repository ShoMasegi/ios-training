import Combine

public struct AnyViewModel<Argument, Action, State>: ViewModel {
    private let getArgument: () -> Argument
    private let getState: () -> State
    private let getStatePublisher: () -> AnyPublisher<State, Never>
    private let send: (Action) -> Void

    public var argument: Argument {
        getArgument()
    }

    public var state: State {
        getState()
    }

    public var statePublisher: AnyPublisher<State, Never> {
        getStatePublisher()
    }

    init<VM>(_ viewModel: VM) where Argument == VM.Argument, Action == VM.Action, State == VM.State, VM: ViewModel {
        getArgument = { viewModel.argument }
        getState = { viewModel.state }
        getStatePublisher = { viewModel.statePublisher }
        send = viewModel.send(action:)
    }

    public func send(action: Action) {
        send(action)
    }
}

public extension ViewModel {
    typealias TypeErased = AnyViewModel<Argument, Action, State>

    func eraseToAnyViewModel() -> TypeErased {
        TypeErased(self)
    }
}
