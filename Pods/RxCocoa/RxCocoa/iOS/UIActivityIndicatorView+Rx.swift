#if os(iOS) || os(tvOS)

    import RxSwift
    import UIKit

    public extension Reactive where Base: UIActivityIndicatorView {
        /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
        var isAnimating: Binder<Bool> {
            Binder(base) { activityIndicator, active in
                if active {
                    activityIndicator.startAnimating()
                } else {
                    activityIndicator.stopAnimating()
                }
            }
        }
    }

#endif
