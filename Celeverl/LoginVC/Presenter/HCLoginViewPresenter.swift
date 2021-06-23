//
//  HCLoginViewPresenter.swift
//  HappyChild (mobile)
//
//  Created by Anna on 02.12.2019.
//  Copyright © 2019 oberon. All rights reserved.
//

import UIKit

class HCLoginViewPresenter: NSObject {

    unowned private var view: HCLoginViewControllerProtocol
    private var model: HCLoginModel
    private var networkService: HCNetworkServiceProtocol?
    
    init(view: HCLoginViewControllerProtocol, model: HCLoginModel) {
        self.view = view
        self.model = model
        self.networkService = HCNetworkService()
    }
    
    private func sendCode() {
        networkService?.checkCode(model.code, forPhoneNumber: model.phoneNumber) { [weak self] (userId, error) in
            if let _ = userId {
                UserDefaults.standard.set(userId!, forKey: "userId")
                print("Success")
            } else if let _ = error {
                self?.view.showCodeError()
            }
        }
       
    }
    
    private func codeRequest() {
        networkService?.checkPhoneNumber(model.phoneNumber, { [weak self] (success, error) in
            if (success) {
                self?.model.isCode = true
                self?.view.showCodeView()
            }
            else if let _ = error {
                self?.model.isCode = false
                self?.view.showPhoneError()
            }
        })
    }
}

extension HCLoginViewPresenter: HCLoginViewPresenterProtocol {
    
    func update(phoneNumber: String) {
        model.phoneNumber = AppConstants.PHONE_NUMBER_PREFIX + phoneNumber
    }
    
    func update(code: String) {
        model.code = code
    }
   
    func sendButtonDidTouchUpInside() {
        if (model.isCode) {
            sendCode()
        } else {
            codeRequest()
        }
    }
    
}
