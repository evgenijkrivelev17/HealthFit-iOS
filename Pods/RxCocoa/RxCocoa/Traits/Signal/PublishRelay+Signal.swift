import RxRelay
import RxSwift

public extension PublishRelay {
    /// Converts `PublishRelay` to `Signal`.
    ///
    /// - returns: Observable sequence.
    func asSignal() -> Signal<Element> {
        let source = asObservable()
            .observe(on: SignalSharingStrategy.scheduler)
        return SharedSequence(source)
    }
}
