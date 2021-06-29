import RxSwift

protocol BaseViewModelProtocol {
    associatedtype InputViewType
    associatedtype OutputViewType

    var input: InputViewType { get }

    func configure(input: InputViewType) -> OutputViewType

    var isBusy: Observable<Bool> { get }
}
