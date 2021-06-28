/// Represents a disposable resource whose underlying disposable resource can be replaced by another disposable resource, causing automatic disposal of the previous underlying disposable resource.
public final class SerialDisposable: DisposeBase, Cancelable {
    private var lock = SpinLock()

    // state
    private var current = nil as Disposable?
    private var disposed = false

    /// - returns: Was resource disposed.
    public var isDisposed: Bool {
        self.disposed
    }

    /// Initializes a new instance of the `SerialDisposable`.
    override public init() {
        super.init()
    }

    /**
     Gets or sets the underlying disposable.

     Assigning this property disposes the previous disposable object.

     If the `SerialDisposable` has already been disposed, assignment to this property causes immediate disposal of the given disposable object.
     */
    public var disposable: Disposable {
        get {
            lock.performLocked {
                self.current ?? Disposables.create()
            }
        }
        set(newDisposable) {
            let disposable: Disposable? = lock.performLocked {
                if self.isDisposed {
                    return newDisposable
                } else {
                    let toDispose = self.current
                    self.current = newDisposable
                    return toDispose
                }
            }

            if let disposable = disposable {
                disposable.dispose()
            }
        }
    }

    /// Disposes the underlying disposable as well as all future replacements.
    public func dispose() {
        _dispose()?.dispose()
    }

    private func _dispose() -> Disposable? {
        lock.performLocked {
            guard !self.isDisposed else { return nil }

            self.disposed = true
            let current = self.current
            self.current = nil
            return current
        }
    }
}
