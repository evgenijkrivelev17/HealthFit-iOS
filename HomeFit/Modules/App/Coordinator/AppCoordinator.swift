import Foundation
import RxSwift
import UIKit

class AppCoordinator: BaseCoordinator<Void> {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let searchDevicesCoordinator = SearchDevicesCoordinator()

        let navigationController = UINavigationController(rootViewController: searchDevicesCoordinator.rootViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.accessibilityFrame = CGRect.zero

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return coordinate(to: searchDevicesCoordinator)
    }
}
