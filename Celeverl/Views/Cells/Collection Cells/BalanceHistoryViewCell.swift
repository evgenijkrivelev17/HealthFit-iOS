//
//  BalanceHistoryViewCell.swift
//  HappyChild (mobile)
//
//  Created by Евгений on 1/20/20.
//  Copyright © 2020 oberon. All rights reserved.
//

import Foundation
import UIKit

public class BalanceHistoryViewCell: BaseViewCell {
    
    public static let reuqseID = "BalanceHistoryViewCell"
    
    var titleView: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 25)
        return label
    }()
    
    var descriptionView: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 15)
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.ListInvokes.append(self.propertyChanged(_:))
        
        self.addSubview(self.titleView)
        self.addSubview(self.descriptionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func propertyChanged(_ propertyName: String) {
        if(propertyName == "BindingContext"){
            updateViewCell()
        }
    }
    
    override public func updateViewCell() {
        self.configuareTitleView()
        self.configuareDescriptionView()
    }
    
    private func configuareTitleView(){
        if let data = self.BindingContext as? HistoryBalanceModel {
            self.titleView.translatesAutoresizingMaskIntoConstraints = false
            
            self.titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
            self.titleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
            self.titleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
            
            if data.HappyChildAnalysisHoursChangeValue > 0 {
                self.titleView.textColor = .systemGreen
            }
            else {
                self.titleView.textColor = .systemRed
            }
            self.titleView.text = String(data.HappyChildAnalysisHoursChangeValue)
        }
    }
    
    private func configuareDescriptionView(){
        if let data = self.BindingContext as? HistoryBalanceModel {
            self.descriptionView.translatesAutoresizingMaskIntoConstraints = false
            
            self.descriptionView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 20).isActive = true
            self.descriptionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
            self.descriptionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
            
            self.descriptionView.textColor = .darkGray
            self.descriptionView.text = String(data.ChangeDateStr)
        }
    }
}
