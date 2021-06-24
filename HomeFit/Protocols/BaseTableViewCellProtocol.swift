//
//  BaseTableViewCellProtocol.swift
//  HomeFit
//
//  Created by Yauheni Kryvialiou on 24.06.21.
//


protocol BaseTableViewCellProtocol{
    
    associatedtype D
    
    var Data: D? { get set }
    
    func setData(to data: D)
    
    func updateBindings()
    
}
