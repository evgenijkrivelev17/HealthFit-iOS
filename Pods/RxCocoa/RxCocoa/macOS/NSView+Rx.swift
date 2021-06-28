#if os(macOS)
    import Cocoa
    import RxSwift

    public extension Reactive where Base: NSView {
        /// Bindable sink for `alphaValue` property.
        var alpha: Binder<CGFloat> {
            return Binder(base) { view, value in
                view.alphaValue = value
            }
        }
    }
#endif
