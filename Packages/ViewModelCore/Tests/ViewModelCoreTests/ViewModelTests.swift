import Combine
@testable import ViewModelCore
import XCTest

final class ViewModelTests: XCTestCase {
    func test_argument_void() {
        let vm = TestViewModel()
        XCTAssertTrue(vm.argument == ())
    }
}

private final class TestViewModel: ViewModel {
    typealias Argument = Void
    typealias Action = Never
    typealias State = Void

    let state: State = ()
    var statePublisher: AnyPublisher<State, Never> { fatalError() }
}
