import RxRelay
import RxSwift

public extension BehaviorRelay {
    /// Converts `BehaviorRelay` to `Driver`.
    ///
    /// - returns: Observable sequence.
    func asDriver() -> Driver<Element> {
        let source = asObservable()
            .observe(on: DriverSharingStrategy.scheduler)
        return SharedSequence(source)
    }
}
