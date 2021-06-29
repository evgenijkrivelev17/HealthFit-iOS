import Foundation
import RxSwift
import UIKit

class SearchDevicesCoordinator: BaseCoordinator<Void> {
    var rootViewController: UIViewController

    override init(id: UUID = UUID(), childCoordinators: [UUID: Any] = [:]) {
        let viewModel = SearchDevicesViewModel(input: SearchDevicesViewModel.Input(searchDeviceTextField: BehaviorSubject(value: ""),
                                                                                   startScan: PublishSubject(),
                                                                                   stopScan: PublishSubject(),
                                                                                   goToDevice: PublishSubject(),
                                                                                   connectDevice: PublishSubject(),
                                                                                   disconnectDevice: PublishSubject()))
        rootViewController = SearchDevicesController(viewModel: viewModel)

        super.init(id: id, childCoordinators: childCoordinators)
    }

    override func start() -> Observable<Void> {
        guard let rootViewController = rootViewController as? UIViewController else {
            return Observable.never()
        }

        return Observable.never()
    }
}
