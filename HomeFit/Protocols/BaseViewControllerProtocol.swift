import RxSwift

public protocol BaseViewControllerProtocol: AnyObject {
    associatedtype ViewModelType

    var viewModel: ViewModelType { get }

    var isBusy: Observable<Bool> { get }

    var isLoaded: Observable<Bool> { get }

    func setUpUI()

    func configure(_ data: [String: AnyObject])
}
