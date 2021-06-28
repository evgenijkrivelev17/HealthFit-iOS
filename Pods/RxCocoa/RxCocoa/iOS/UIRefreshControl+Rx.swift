#if os(iOS)

    import RxSwift
    import UIKit

    public extension Reactive where Base: UIRefreshControl {
        /// Bindable sink for `beginRefreshing()`, `endRefreshing()` methods.
        var isRefreshing: Binder<Bool> {
            return Binder(base) { refreshControl, refresh in
                if refresh {
                    refreshControl.beginRefreshing()
                } else {
                    refreshControl.endRefreshing()
                }
            }
        }
    }

#endif
