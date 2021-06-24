//
//  BaseViewControllerProtocol.swift
//  HomeFit
//
//  Created by Евгений on 30.05.21.
//

public protocol BaseViewControllerProtocol: AnyObject {
    func configure(_ data: [String: AnyObject])
    func back()
}
