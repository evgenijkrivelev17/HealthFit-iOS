public protocol BaseViewControllerProtocol: AnyObject {
    func configure(_ data: [String: AnyObject])
    func back()
}
