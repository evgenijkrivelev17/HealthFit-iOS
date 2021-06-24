//
//  BaseViewControllerProtocol.swift
//  HomeFit
//
//  Created by Евгений on 30.05.21.
//


public protocol BaseViewControllerProtocol: class {
    
    func configure(_ data: [String: AnyObject])
    func back()
}
