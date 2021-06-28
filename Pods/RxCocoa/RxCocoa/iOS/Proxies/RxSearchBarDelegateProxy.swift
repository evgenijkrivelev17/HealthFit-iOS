#if os(iOS) || os(tvOS)

    import RxSwift
    import UIKit

    extension UISearchBar: HasDelegate {
        public typealias Delegate = UISearchBarDelegate
    }

    /// For more information take a look at `DelegateProxyType`.
    open class RxSearchBarDelegateProxy:
        DelegateProxy<UISearchBar, UISearchBarDelegate>,
        DelegateProxyType,
        UISearchBarDelegate
    {
        /// Typed parent object.
        public private(set) weak var searchBar: UISearchBar?

        /// - parameter searchBar: Parent object for delegate proxy.
        public init(searchBar: ParentObject) {
            self.searchBar = searchBar
            super.init(parentObject: searchBar, delegateProxy: RxSearchBarDelegateProxy.self)
        }

        // Register known implementations
        public static func registerKnownImplementations() {
            register { RxSearchBarDelegateProxy(searchBar: $0) }
        }
    }

#endif
