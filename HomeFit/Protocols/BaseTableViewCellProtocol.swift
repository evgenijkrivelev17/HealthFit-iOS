protocol BaseTableViewCellProtocol {
    associatedtype Data

    var data: Data? { get set }

    func setData(to data: Data)
    func updateValues()
}
