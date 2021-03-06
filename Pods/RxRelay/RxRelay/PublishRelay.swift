import RxSwift

/// PublishRelay is a wrapper for `PublishSubject`.
///
/// Unlike `PublishSubject` it can't terminate with error or completed.
public final class PublishRelay<Element>: ObservableType {
    private let subject: PublishSubject<Element>

    // Accepts `event` and emits it to subscribers
    public func accept(_ event: Element) {
        subject.onNext(event)
    }

    /// Initializes with internal empty subject.
    public init() {
        subject = PublishSubject()
    }

    /// Subscribes observer
    public func subscribe<Observer: ObserverType>(_ observer: Observer) -> Disposable where Observer.Element == Element {
        subject.subscribe(observer)
    }

    /// - returns: Canonical interface for push style sequence
    public func asObservable() -> Observable<Element> {
        subject.asObservable()
    }
}
