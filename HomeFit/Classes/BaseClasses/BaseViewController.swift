//
//  BaseViewController.swift
//  HomeFit
//
//  Created by Евгений on 30.05.21.
//

import UIKit


public class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    public func configure(_ data: [String:AnyObject]) {
        
    }
    
    public func back() {
        
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





