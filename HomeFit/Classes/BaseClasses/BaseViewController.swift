import RxCocoa
import RxSwift
import UIKit

class BaseViewController<ViewModelType: BaseViewModelProtocol>: UIViewController, BaseViewControllerProtocol {
    public private(set) var isLoaded: Observable<Bool>

    public private(set) var isBusy: Observable<Bool>

    var viewModel: ViewModelType

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(model: ViewModelType,
                isLoadedObserver: Observable<Bool> = BehaviorSubject(value: false).asObservable(),
                isBusyObserver: Observable<Bool> = BehaviorSubject(value: false).asObservable())
    {
        isLoaded = isLoadedObserver
        isBusy = isBusyObserver
        viewModel = model
        isBusy = model.isBusy
        super.init(nibName: nil, bundle: nil)
    }

    public func setUpUI() {}

    public func configure(_: [String: AnyObject]) {}
}
