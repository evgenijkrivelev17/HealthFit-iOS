import RxSwift

protocol BaseViewModelProtocol {
    associatedtype InputViewType
    associatedtype OutputViewType

    var input: InputViewType { get }

    var isBusy: Observable<Bool> { get }

    func configure(input: InputViewType) -> OutputViewType
}
