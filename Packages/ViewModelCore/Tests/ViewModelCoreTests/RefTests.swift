@testable import ViewModelCore
import XCTest

final class RefTests: XCTestCase {
    func test_equal() {
        let ref = Ref(1)
        XCTAssertEqual(ref, ref)
        XCTAssertNotEqual(ref, Ref(1))
    }

    func test_init_void() {
        let ref = Ref()
        XCTAssertTrue(ref.value == ())
    }
}
