//
//  BaseViewModelProtocol.swift
//  HomeFit
//
//  Created by Евгений on 30.05.21.
//

public protocol BaseViewModelProtocol {
    associatedtype I
    associatedtype O

    var inputData: I { get }

    func configure(_ data: AnyObject)
    func transform(input: I) -> O
}
