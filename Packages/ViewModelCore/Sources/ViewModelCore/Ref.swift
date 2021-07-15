public final class Ref<Value>: Equatable {
    public static func == (lhs: Ref<Value>, rhs: Ref<Value>) -> Bool {
        lhs === rhs
    }

    public let value: Value

    public init(_ value: Value) {
        self.value = value
    }
}

public extension Ref where Value == Void {
    convenience init() {
        self.init(())
    }
}
