import UIKit

public class BaseTableViewCell<T>: UITableViewCell, BaseTableViewCellProtocol {
    typealias DataType = T

    var data: T?

    func setData(to data: DataType) {
        self.data = data
        updateValues()
    }

    func updateValues() {}
}
