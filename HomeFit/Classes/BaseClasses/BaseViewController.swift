import RxCocoa
import RxSwift
import UIKit

class BaseViewController<ViewModelType: BaseViewModelProtocol>: UIViewController, BaseViewControllerProtocol {
    private(set) var isBusy: Observable<Bool>

    var viewModel: ViewModelType

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(model: ViewModelType) {
        viewModel = model
        isBusy = model.isBusy
        super.init(nibName: nil, bundle: nil)
    }

    func setUpUI() {}

    func configure(_: [String: AnyObject]) {}

    func bindViewModel() {}

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bindViewModel()
    }
}
