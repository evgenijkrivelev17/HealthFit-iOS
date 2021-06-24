//
//  BaseTableViewCell.swift
//  HomeFit
//
//  Created by Евгений on 4/19/21.
//

import UIKit

public class BaseTableViewCell<T>: UITableViewCell, BaseTableViewCellProtocol {
    typealias DataType = T

    var data: T?

    func setData(to data: DataType) {
        self.data = data
    }

    func updateValues() {}
}
