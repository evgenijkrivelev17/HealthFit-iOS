#if os(iOS) || os(tvOS)

    import RxSwift
    import UIKit

    extension UITabBarController: HasDelegate {
        public typealias Delegate = UITabBarControllerDelegate
    }

    /// For more information take a look at `DelegateProxyType`.
    open class RxTabBarControllerDelegateProxy:
        DelegateProxy<UITabBarController, UITabBarControllerDelegate>,
        DelegateProxyType,
        UITabBarControllerDelegate
    {
        /// Typed parent object.
        public private(set) weak var tabBar: UITabBarController?

        /// - parameter tabBar: Parent object for delegate proxy.
        public init(tabBar: ParentObject) {
            self.tabBar = tabBar
            super.init(parentObject: tabBar, delegateProxy: RxTabBarControllerDelegateProxy.self)
        }

        // Register known implementations
        public static func registerKnownImplementations() {
            register { RxTabBarControllerDelegateProxy(tabBar: $0) }
        }
    }

#endif
