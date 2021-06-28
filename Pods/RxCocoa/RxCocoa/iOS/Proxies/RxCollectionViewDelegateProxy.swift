#if os(iOS) || os(tvOS)

    import RxSwift
    import UIKit

    /// For more information take a look at `DelegateProxyType`.
    open class RxCollectionViewDelegateProxy:
        RxScrollViewDelegateProxy,
        UICollectionViewDelegate,
        UICollectionViewDelegateFlowLayout
    {
        /// Typed parent object.
        public private(set) weak var collectionView: UICollectionView?

        /// Initializes `RxCollectionViewDelegateProxy`
        ///
        /// - parameter collectionView: Parent object for delegate proxy.
        public init(collectionView: UICollectionView) {
            self.collectionView = collectionView
            super.init(scrollView: collectionView)
        }
    }

#endif
