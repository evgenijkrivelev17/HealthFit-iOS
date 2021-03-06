/// Represents an observable sequence of elements that have a common key.
public struct GroupedObservable<Key, Element>: ObservableType {
    /// Gets the common key.
    public let key: Key

    private let source: Observable<Element>

    /// Initializes grouped observable sequence with key and source observable sequence.
    ///
    /// - parameter key: Grouped observable sequence key
    /// - parameter source: Observable sequence that represents sequence of elements for the key
    /// - returns: Grouped observable sequence of elements for the specific key
    public init(key: Key, source: Observable<Element>) {
        self.key = key
        self.source = source
    }

    /// Subscribes `observer` to receive events for this sequence.
    public func subscribe<Observer: ObserverType>(_ observer: Observer) -> Disposable where Observer.Element == Element {
        source.subscribe(observer)
    }

    /// Converts `self` to `Observable` sequence.
    public func asObservable() -> Observable<Element> {
        source
    }
}
