//
//  HCSettingsViewController + DaySelection.swift
//  HappyChild (mobile)
//
//  Created by Anna on 17.12.2019.
//  Copyright © 2019 oberon. All rights reserved.
//

import UIKit

extension HCSettingsViewController {
    
    func setupDaySelectionView() {
        daySelectionView.isHidden = true
        
        daySelectionTitleLabel.text = String.localize("Выберите дни:")
        
        for (index, label) in daySelectionLabels.enumerated() {
            let text = HCDays.allCases[index].rawValue
            
            label.text = String.localize(text)
        }
        
        for button in daySelectionButtons {
            let index = daySelectionButtons.lastIndex(of: button)!
            button.isSelected = presenter.isDaySelectedByIndex(index)
            
            let imageName = button.isSelected ? "icon_selectedCheckbox" : "icon_deselectedCheckbox"
            button.setImage(UIImage(named: imageName), for: .normal)
            
            button.addTarget(self, action: #selector(daySelectionButtonDidTouchUpInside(_:)), for: .touchUpInside)
        }
    }
    
    @objc func daySelectionButtonDidTouchUpInside(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        let imageName = sender.isSelected ? "icon_selectedCheckbox" : "icon_deselectedCheckbox"
        
        sender.setImage(UIImage(named: imageName), for: .normal)
        
        let index = daySelectionButtons.lastIndex(of: sender)!
        presenter.updateSelectedDays(with: index)
        
    }
}
