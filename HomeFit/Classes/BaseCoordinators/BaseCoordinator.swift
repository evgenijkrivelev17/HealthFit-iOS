import Foundation
import RxSwift

class BaseCoordinator<ResultType>: NSObject {
    public typealias CoordinationResult = ResultType

    private let id: UUID
    private var childCoordinators: [UUID: Any]

    public let disposeBag = DisposeBag()

    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.id] = coordinator
    }

    private func release<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.id] = nil
    }

    init(id: UUID = UUID(), childCoordinators: [UUID: Any] = [:]) {
        self.id = id
        self.childCoordinators = childCoordinators
    }

    @discardableResult
    open func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in
                self?.release(coordinator: coordinator)
            })
    }

    open func start() -> Observable<ResultType> {
        fatalError("start() method must be implemented")
    }
}
