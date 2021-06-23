//
//  SettingsInteractor.swift
//  Cleverl
//
//  Created by Евгений on 2/16/20.
//  Copyright © 2020 oberon. All rights reserved.
//

import Foundation


public class SettingsInteractor: SettingsInteractorProtocol {
    
    public var presenter: SettingsPresenterProtocol?
    
    public var worker: SettingsWorkerProtocol?
    
    public var router: SettingsRouterProtocol?
    
    public var isBusy: Bool = false
    
    public func back() {
        
    }
    
    public func getNotifications() {
        
    }
    
    public func getDataSource() -> [String : Any] {
        return [:]
    }
    
    public func setCustomData(source: BaseDataSourceProtocol) {
        
    }
}
