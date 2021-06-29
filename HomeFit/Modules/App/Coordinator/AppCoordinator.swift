import Foundation
import RxSwift
import UIKit

class AppCoordinator: BaseCoordinator<Void> {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init(id: UUID(), childCoordinators: [:])
    }

    override func start() -> Observable<Void> {
        let searchDevicesCoordinator = SearchDevicesCoordinator()

        let navigationController = UINavigationController(rootViewController: searchDevicesCoordinator.rootViewController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return coordinate(to: searchDevicesCoordinator)
    }
}
