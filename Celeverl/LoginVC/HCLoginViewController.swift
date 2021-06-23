//
//  HCLoginViewController.swift
//  HappyChild (mobile)
//
//  Created by Anna on 02.12.2019.
//  Copyright © 2019 oberon. All rights reserved.
//

import UIKit

class HCLoginViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet private weak var phoneNumberView: UIView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var phonePrefixLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet private weak var sendButton: UIButton!
    
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    
    var presenter: HCLoginViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
//        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    
        NotificationCenter.default.addObserver( self, selector: #selector(keyboardWillShow(notification:)), name:  UIResponder.keyboardWillShowNotification, object: nil )
        NotificationCenter.default.addObserver( self, selector: #selector(keyboardWillHide(notification:)), name:  UIResponder.keyboardWillHideNotification, object: nil )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    
    //MARK: - Setups

    private func setupPresenter() {
        let model = HCLoginModel()
        let presenter = HCLoginViewPresenter(view: self, model: model)
        
        self.presenter = presenter
    }
    
    private func setupUI() {
        backgroundView.layer.cornerRadius = 10
        
        phoneNumberView.layer.cornerRadius = 4
        phoneNumberView.isHidden = false
        
        titleLabel.text = String.localize("Авторизация")
        subtitleLabel.text = String.localize("Мы отправим вам смс с кодом доступа")
        descriptionLabel.text = String.localize("Ваш телефон:")
        phonePrefixLabel.text = AppConstants.PHONE_NUMBER_PREFIX
        
        errorLabel.isHidden = true
        errorLabel.text = ""
        
        sendButton.setTitle(String.localize("Отправить код"), for: .normal)
        sendButton.layer.cornerRadius = 4
        
        phoneNumberTextField.delegate = self
        phoneNumberTextField.text = ""
        phoneNumberTextField.placeholder = "9001231234"
        
        codeTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
        codeTextField.isHidden = true
        codeTextField.layer.cornerRadius = 4
        codeTextField.delegate = self
        codeTextField.text = ""
        codeTextField.placeholder = String.localize("Например 12314")
    }
    
    //MARK: - Actions
    
    @IBAction func sendButtonDidTouchUpInside(_ sender: Any) {
//        dismissKeyboard()
        presenter.sendButtonDidTouchUpInside()

    }
}

//MARK: - HCLoginViewControllerProtocol

extension HCLoginViewController: HCLoginViewControllerProtocol {
    
    func showCodeView() {
        DispatchQueue.main.async {
            self.errorLabel.isHidden = true
            self.titleLabel.text = String.localize("Подтверждение авторизации")
            self.subtitleLabel.text = String.localize("Введите код из СМС")
            self.descriptionLabel.text = String.localize("Код из СМС:")
            self.phoneNumberView.isHidden = true
            self.codeTextField.isHidden = false
            
            self.sendButton.setTitle(String.localize("Подтвердить"), for: .normal)
        }
    }
    
    func showPhoneError() {
        DispatchQueue.main.async {
            self.errorLabel.text = String.localize("Некорректный номер телефона, повторите попытку")
            self.errorLabel.isHidden = false
        }
    }
    
    func showCodeError() {
        DispatchQueue.main.async {
            self.errorLabel.text = String.localize("Введен неверный код")
            self.errorLabel.isHidden = false
        }
    }
}

