/// Represents a disposable resource that can be checked for disposal status.
public final class BooleanDisposable: Cancelable {
    internal static let BooleanDisposableTrue = BooleanDisposable(isDisposed: true)
    private var disposed = false

    /// Initializes a new instance of the `BooleanDisposable` class
    public init() {}

    /// Initializes a new instance of the `BooleanDisposable` class with given value
    public init(isDisposed: Bool) {
        disposed = isDisposed
    }

    /// - returns: Was resource disposed.
    public var isDisposed: Bool {
        disposed
    }

    /// Sets the status to disposed, which can be observer through the `isDisposed` property.
    public func dispose() {
        disposed = true
    }
}
