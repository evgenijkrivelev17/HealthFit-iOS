//
//  AppLogInPanel.swift
//  HappyChild
//
//  Created by Евгений on 11/11/19.
//  Copyright © 2019 Oberon. All rights reserved.
//

import Foundation
import UIKit

//MARK: - LognInPanel
public class LognInPanel: UIView {
    
    //MARK: - Views
    private lazy var title: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: AppConstants.APP_AVENIR_BOLD, size: 20)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingHead
        label.numberOfLines = 1
        return label
    }()
    public lazy var field: UITextField = {
        var field = UITextField()
        field.backgroundColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1)
        field.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        field.layer.cornerRadius = 10
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftViewMode = UITextField.ViewMode.always
        field.font = UIFont(name: AppConstants.APP_AVENIR_BOLD, size: 18)
        return field
    }()
    public lazy var button: AppCustomButton = {
        var button = AppCustomButton()
        button.tintColor = .white
        button.titleLabel?.font = UIFont(name: AppConstants.APP_AVENIR_BOLD, size: 18)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return button
    }()
    public lazy var codeButton: AppCustomButton = {
        var button = AppCustomButton()
        button.tintColor = .white
        button.titleLabel?.font = UIFont(name: AppConstants.APP_AVENIR_BOLD, size: 18)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        return button
    }()
    private lazy var errorLabel:UILabel = {
        var label = UILabel()
        label.font = UIFont(name: AppConstants.APP_AVENIR_BOLD, size: 18)
        label.textColor = .systemRed
        label.numberOfLines = 0
        return label
    }()
    public lazy var agreementTitleView: UILabel = {
       var label = UILabel()
       label.textColor = .systemGray
       label.font = UIFont(name: AppConstants.APP_ROBOTO_MEDIUM, size: 12)
       label.numberOfLines = 0
       label.textAlignment = .center
       return label
    }()
    
    //MARK: - Properties
    public var titleText:String = "" {
        didSet{
            self.title.text = self.titleText
        }
    }
    
    public var titleButtonText: String = "" {
        didSet{
             self.button.setTitle(titleButtonText, for: .normal)
        }
    }
    
    public var errorText: String = "" {
        didSet{
            self.errorLabel.text = self.errorText
        }
    }
    
    public var placeHolderText: String = "" {
        didSet{
            self.field.placeholder = self.placeHolderText
        }
    }
    
    public var buttonText: String = "" {
        didSet{
             self.codeButton.setTitle(buttonText, for: .normal)
        }
    }
    
    public var errorTextColor: UIColor = .red {
        didSet{
            self.errorLabel.textColor = self.errorTextColor
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.configuarePanel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Configaure functions
    private func configuarePanel(){
        
        self.addSubview(self.title)
        self.configuareTitle()
        
        self.addSubview(self.button)
        self.configuareButton()
        
        self.addSubview(field)
        self.configuareTextField()
        
        self.addSubview(codeButton)
        self.configuareSendButton()
        

        self.addSubview(self.agreementTitleView)
        self.cogfiguareAgreementView()
        
        self.addSubview(errorLabel)
        self.configuareErrorLabel()
    }
    
    open func configuareTitle() {
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.title.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.title.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.title.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    open func configuareButton() {
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 20).isActive = true
        self.button.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    open func configuareTextField() {
        self.field.translatesAutoresizingMaskIntoConstraints = false
        self.field.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 20).isActive = true
        self.field.leftAnchor.constraint(equalTo: self.button.rightAnchor, constant: 0).isActive = true
        self.field.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.field.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    open func configuareSendButton(){
        self.codeButton.translatesAutoresizingMaskIntoConstraints = false
        self.codeButton.topAnchor.constraint(equalTo: self.field.bottomAnchor, constant: 20).isActive = true
        self.codeButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.codeButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.codeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    open func cogfiguareAgreementView(){
        self.agreementTitleView.text = "Авторизуясь или регистрируясь, вы соглашаетесь с условиями обработки ваших персональных данных"

        self.agreementTitleView.translatesAutoresizingMaskIntoConstraints = false
        self.agreementTitleView.topAnchor.constraint(equalTo:codeButton.bottomAnchor, constant: 20).isActive = true
        self.agreementTitleView.widthAnchor.constraint(equalTo:codeButton.widthAnchor).isActive = true
        self.agreementTitleView.centerXAnchor.constraint(equalTo:codeButton.centerXAnchor , constant: 0).isActive = true
        self.agreementTitleView.isUserInteractionEnabled = true
    }
    
    open func configuareErrorLabel(){
        self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.errorLabel.topAnchor.constraint(equalTo: self.agreementTitleView.bottomAnchor, constant: 10).isActive = true
        self.errorLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.errorLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
       
    }
    
    //MARK: - Animation functions
    func HideError(){
        CATransaction.begin()
        let hideTextAnimation = CABasicAnimation(keyPath: "textColor")
        hideTextAnimation.fromValue = self.errorLabel.textColor
        hideTextAnimation.toValue = UIColor.clear
        hideTextAnimation.duration = 1
        CATransaction.setCompletionBlock({
            self.errorLabel.textColor = UIColor.clear
        })
        CATransaction.commit()
    }
    
    func ShowError(){
        CATransaction.begin()
        let showErrorTextAnimation = CABasicAnimation(keyPath: "textColor")
        showErrorTextAnimation.fromValue = self.errorLabel.textColor
        showErrorTextAnimation.toValue = self.errorTextColor
        showErrorTextAnimation.duration = 1
        CATransaction.setCompletionBlock({
            self.errorLabel.textColor = self.errorTextColor
        })
        CATransaction.commit()
    }
    
}
