//
//  HCSettingsViewController + DateSelection.swift
//  HappyChild (mobile)
//
//  Created by Anna on 19.12.2019.
//  Copyright © 2019 oberon. All rights reserved.
//

import Foundation
import UIKit

//@IBOutlet weak var dateSelectionView: UIView!
//@IBOutlet weak var dateSelectionTitleLabel: UILabel!
//@IBOutlet weak var dateSelectionBackView: UIView!
//@IBOutlet weak var startDateLabel: UILabel!
//@IBOutlet weak var endDateLabel: UILabel!

extension HCSettingsViewController {
    
    func setupDateSelectionView() {
        dateSelectionView.isHidden = true
        
        dateSelectionTitleLabel.text = String.localize("Выберите даты:")
        
        dateSelectionBackView.layer.borderColor = UIColor.systemGray.cgColor
        dateSelectionBackView.layer.borderWidth = 2
        dateSelectionBackView.layer.cornerRadius = 10
        
        startDateLabel.text = Date.stringFrom(date: Date())
        endDateLabel.text = Date.stringFrom(date: Date().dayAfter)
    }
    
    
    @IBAction func startDateButtonDidTouchUpInside(_ sender: UIButton) {
        activeButton = sender
        showStartDatePicker()
    }
    
    @IBAction func endDateButtonDidTouchUpInside(_ sender: UIButton) {
        activeButton = sender
        showEndDatePicker()
    }
}
