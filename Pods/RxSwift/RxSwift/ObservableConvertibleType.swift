/// Type that can be converted to observable sequence (`Observable<Element>`).
public protocol ObservableConvertibleType {
    /// Type of elements in sequence.
    associatedtype Element

    /// Converts `self` to `Observable` sequence.
    ///
    /// - returns: Observable sequence that represents `self`.
    func asObservable() -> Observable<Element>
}
