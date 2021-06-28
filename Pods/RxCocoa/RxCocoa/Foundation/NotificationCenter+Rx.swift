import Foundation
import RxSwift

public extension Reactive where Base: NotificationCenter {
    /**
     Transforms notifications posted to notification center to observable sequence of notifications.

     - parameter name: Optional name used to filter notifications.
     - parameter object: Optional object used to filter notifications.
     - returns: Observable sequence of posted notifications.
     */
    func notification(_ name: Notification.Name?, object: AnyObject? = nil) -> Observable<Notification> {
        return Observable.create { [weak object] observer in
            let nsObserver = self.base.addObserver(forName: name, object: object, queue: nil) { notification in
                observer.on(.next(notification))
            }

            return Disposables.create {
                self.base.removeObserver(nsObserver)
            }
        }
    }
}
