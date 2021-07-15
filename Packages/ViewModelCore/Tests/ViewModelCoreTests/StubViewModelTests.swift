import Combine
@testable import ViewModelCore
import XCTest

final class StubViewModelTests: XCTestCase {
    func test_argument() {
        let vm = TestViewModel.stub(argument: 1, state: .init())
        XCTAssertEqual(vm.argument, 1)
    }

    func test_argument_void() {
        let vm = NoArgumentTestViewModel.stub(state: ())
        XCTAssertTrue(vm.argument == ())
    }

    func test_state() {
        let vm = TestViewModel.stub(argument: 0, state: .init(name: "test"))
        XCTAssertEqual(vm.state.name, "test")

        vm.state.name = "modified"
        XCTAssertEqual(vm.state.name, "modified")
    }

    func test_statePublisher() {
        let vm = TestViewModel.stub(argument: 0, state: .init())

        var state: TestViewModel.State?
        let cancellable = vm.statePublisher.sink { state = $0 }
        defer { cancellable.cancel() }
        XCTAssertEqual(state?.name, "")

        vm.state.name = "test"
        XCTAssertEqual(state?.name, "test")
    }

    func test_send() {
        let vm = TestViewModel.stub(argument: 0, state: .init())
        XCTAssertTrue(vm.actions.isEmpty)

        vm.send(action: .tap)
        XCTAssertEqual(vm.actions, [.tap])
    }
}

private final class TestViewModel: ViewModel {
    enum Action {
        case tap
    }

    struct State {
        var name: String = ""
    }

    let argument: Int = 0
    let state: State = .init()
    var statePublisher: AnyPublisher<State, Never> { fatalError() }

    func send(action: Action) {}
}

private final class NoArgumentTestViewModel: ViewModel {
    typealias Argument = Void
    typealias Action = Never
    typealias State = Void

    let state: State = ()
    var statePublisher: AnyPublisher<State, Never> { fatalError() }
}
