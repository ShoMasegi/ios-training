import Combine

public protocol ViewModel {
    associatedtype Argument
    associatedtype Action
    associatedtype State

    var argument: Argument { get }
    var state: State { get }
    var statePublisher: AnyPublisher<State, Never> { get }

    func send(action: Action)
}

public extension ViewModel where Argument == Void {
    var argument: Argument {
        ()
    }
}

public extension ViewModel where Action == Never {
    func send(action: Action) {}
}
