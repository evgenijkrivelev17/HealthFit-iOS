#if os(iOS) || os(tvOS)

    import RxSwift
    import UIKit

    extension UITableView: HasDataSource {
        public typealias DataSource = UITableViewDataSource
    }

    private let tableViewDataSourceNotSet = TableViewDataSourceNotSet()

    private final class TableViewDataSourceNotSet:
        NSObject,
        UITableViewDataSource
    {
        func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
            0
        }

        func tableView(_: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
            rxAbstractMethod(message: dataSourceNotSet)
        }
    }

    /// For more information take a look at `DelegateProxyType`.
    open class RxTableViewDataSourceProxy:
        DelegateProxy<UITableView, UITableViewDataSource>,
        DelegateProxyType,
        UITableViewDataSource
    {
        /// Typed parent object.
        public private(set) weak var tableView: UITableView?

        /// - parameter tableView: Parent object for delegate proxy.
        public init(tableView: UITableView) {
            self.tableView = tableView
            super.init(parentObject: tableView, delegateProxy: RxTableViewDataSourceProxy.self)
        }

        // Register known implementations
        public static func registerKnownImplementations() {
            register { RxTableViewDataSourceProxy(tableView: $0) }
        }

        private weak var _requiredMethodsDataSource: UITableViewDataSource? = tableViewDataSourceNotSet

        // MARK: delegate

        /// Required delegate method implementation.
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            (_requiredMethodsDataSource ?? tableViewDataSourceNotSet).tableView(tableView, numberOfRowsInSection: section)
        }

        /// Required delegate method implementation.
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            (_requiredMethodsDataSource ?? tableViewDataSourceNotSet).tableView(tableView, cellForRowAt: indexPath)
        }

        /// For more information take a look at `DelegateProxyType`.
        override open func setForwardToDelegate(_ forwardToDelegate: UITableViewDataSource?, retainDelegate: Bool) {
            _requiredMethodsDataSource = forwardToDelegate ?? tableViewDataSourceNotSet
            super.setForwardToDelegate(forwardToDelegate, retainDelegate: retainDelegate)
        }
    }

#endif
