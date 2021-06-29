import RxSwift

public protocol BaseViewControllerProtocol: AnyObject {
    associatedtype ViewModelType

    var viewModel: ViewModelType { get }

    var isBusy: Observable<Bool> { get }

    func setUpUI()

    func configure(_ data: [String: AnyObject])

    func bindViewModel()
}
