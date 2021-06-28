#if os(iOS) || os(tvOS)

    import RxSwift
    import UIKit

    /// Marks data source as `UITableView` reactive data source enabling it to be used with one of the `bindTo` methods.
    public protocol RxTableViewDataSourceType /*: UITableViewDataSource */ {
        /// Type of elements that can be bound to table view.
        associatedtype Element

        /// New observable sequence event observed.
        ///
        /// - parameter tableView: Bound table view.
        /// - parameter observedEvent: Event
        func tableView(_ tableView: UITableView, observedEvent: Event<Element>)
    }

#endif
