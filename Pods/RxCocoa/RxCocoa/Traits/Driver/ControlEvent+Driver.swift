import RxSwift

public extension ControlEvent {
    /// Converts `ControlEvent` to `Driver` trait.
    ///
    /// `ControlEvent` already can't fail, so no special case needs to be handled.
    func asDriver() -> Driver<Element> {
        return asDriver { _ -> Driver<Element> in
            #if DEBUG
                rxFatalError("Somehow driver received error from a source that shouldn't fail.")
            #else
                return Driver.empty()
            #endif
        }
    }
}
