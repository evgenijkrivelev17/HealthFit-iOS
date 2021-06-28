/// A type-erased `ObservableType`.
///
/// It represents a push style sequence.
public class Observable<Element>: ObservableType {
    init() {
        #if TRACE_RESOURCES
            _ = Resources.incrementTotal()
        #endif
    }

    public func subscribe<Observer: ObserverType>(_: Observer) -> Disposable where Observer.Element == Element {
        rxAbstractMethod()
    }

    public func asObservable() -> Observable<Element> { self }

    deinit {
        #if TRACE_RESOURCES
            _ = Resources.decrementTotal()
        #endif
    }
}
