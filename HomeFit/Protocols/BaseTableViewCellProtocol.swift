protocol BaseTableViewCellProtocol {
    associatedtype D

    var data: D? { get set }

    func setData(to data: D)
    func updateValues()
}
