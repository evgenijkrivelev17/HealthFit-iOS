//
//  AcceptInteractorProtocol.swift
//  HappyChild (mobile)
//
//  Created by Евгений on 11/29/19.
//  Copyright © 2019 oberon. All rights reserved.
//

import Foundation

public protocol SettingsInteractorProtocol: BaseDataSourceProtocol {
    
    var presenter: SettingsPresenterProtocol? {get set}
    var worker: SettingsWorkerProtocol? {get set}
    var router: SettingsRouterProtocol? {get set}
    
    var isBusy: Bool { get set}
    
    func back()
    func getNotifications()
}
