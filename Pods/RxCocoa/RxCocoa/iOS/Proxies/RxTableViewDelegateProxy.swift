#if os(iOS) || os(tvOS)

    import RxSwift
    import UIKit

    /// For more information take a look at `DelegateProxyType`.
    open class RxTableViewDelegateProxy:
        RxScrollViewDelegateProxy,
        UITableViewDelegate
    {
        /// Typed parent object.
        public private(set) weak var tableView: UITableView?

        /// - parameter tableView: Parent object for delegate proxy.
        public init(tableView: UITableView) {
            self.tableView = tableView
            super.init(scrollView: tableView)
        }
    }

#endif
