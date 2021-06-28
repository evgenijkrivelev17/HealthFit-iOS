import RxSwift

protocol BaseViewModelProtocol {
    associatedtype InputViewModel
    associatedtype OutputViewModel

    var input: InputViewModel { get }

    func configure() -> OutputViewModel

    var isBusy: Observable<Bool> { get }
}
