//
//  HCLoginVC+TextField.swift
//  HappyChild (mobile)
//
//  Created by Anna on 02.12.2019.
//  Copyright © 2019 oberon. All rights reserved.
//

import UIKit

extension HCLoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText:String = textField.text else {return true}
        
        if string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil { return false }
        let newCount:Int = currentText.count + string.count - range.length
               
        if(newCount > AppConstants.PHONE_NUMBER_LENGHT){
            return false
        }

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == codeTextField) {
            
        } else {
            presenter.update(phoneNumber: textField.text!)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            self.errorLabel.isHidden = true
        }
    }
}
