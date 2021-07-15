import Combine
@testable import ViewModelCore
import XCTest

final class AnyViewModelTests: XCTestCase {
    func test_argument() {
        let vm = TestViewModel(argument: 1).eraseToAnyViewModel()
        XCTAssertEqual(vm.argument, 1)
    }

    func test_state() {
        let vm = TestViewModel().eraseToAnyViewModel()
        XCTAssertTrue(vm.state.name.isEmpty)

        vm.send(action: .tap)
        XCTAssertEqual(vm.state.name, "1")
    }

    func test_statePublisher() {
        let vm = TestViewModel().eraseToAnyViewModel()

        var state: TestViewModel.State?
        let cancellable = vm.statePublisher.sink { state = $0 }

        withExtendedLifetime(cancellable) {
            XCTAssertEqual(state?.name, "")

            vm.send(action: .tap)
            XCTAssertEqual(state?.name, "1")
        }
    }

    func test_send() {
        let testVM = TestViewModel()
        let vm = testVM.eraseToAnyViewModel()
        XCTAssertTrue(testVM.actions.isEmpty)

        vm.send(action: .tap)
        XCTAssertEqual(testVM.actions, [.tap])
    }
}

private final class TestViewModel: ViewModel {
    enum Action {
        case tap
    }

    struct State {
        var name: String = ""
    }

    let argument: Int
    @Published private(set) var state: State = .init()
    var statePublisher: AnyPublisher<State, Never> { $state.eraseToAnyPublisher() }

    init(argument: Int = 0) {
        self.argument = argument
    }

    private(set) var actions: [Action] = []

    func send(action: Action) {
        actions.append(action)

        state.name = actions.count.description
    }
}
