//
//  SettingsViewer.swift
//  Cleverl
//
//  Created by Евгений on 2/16/20.
//  Copyright © 2020 oberon. All rights reserved.
//

import Foundation
import UIKit


//MARK: - SettingsViewer
public class SettingsViewer: UIViewController, SettingsViewerProtocol {
    
    //MARK: - SettingsViewerProtocol implementation
    public var interactor: SettingsInteractorProtocol?
    
    public var router: SettingsRouterProtocol?
    
    public func showError(error: String) {
        
    }
    
    public func hideError() {
        
    }
    
    public func changedBusyState(_ state: Bool) {
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    
    //MARK: - Configuare Views functions
    
    
    private func confgiaureViews(){
    }
}
