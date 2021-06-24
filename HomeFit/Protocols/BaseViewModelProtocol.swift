//
//  BaseViewModelProtocol.swift
//  HomeFit
//
//  Created by Евгений on 30.05.21.
//


public protocol BaseViewModelProtocol {
    
    associatedtype I
    associatedtype O
    
    var Input: I { get }
    
    func configure(_ data: AnyObject)
    func transform(Input: I) -> O
    
}
