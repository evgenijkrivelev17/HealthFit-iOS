public protocol BaseViewModelProtocol {
    associatedtype I
    associatedtype O

    var inputData: I { get }

    func configure(_ data: AnyObject)
    func transform(input: I) -> O
}
