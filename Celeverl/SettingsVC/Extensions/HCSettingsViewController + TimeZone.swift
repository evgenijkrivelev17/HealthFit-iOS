//
//  HCSettingsViewController + TimeZone.swift
//  HappyChild (mobile)
//
//  Created by Anna on 15.12.2019.
//  Copyright © 2019 oberon. All rights reserved.
//

import UIKit

extension HCSettingsViewController {
    
    func setupTimeZoneViews() {
        timeZoneTitleLabel.text = String.localize("Время:")
        timeZoneArrowImageView.image = UIImage(named: "icon_arrowUp")
        timeZoneView.isHidden = true
        timeZoneViewTitleLabel.text = String.localize("Часовой пояс")
        
        saveTimeZoneButton.layer.masksToBounds = false
        saveTimeZoneButton.layer.shadowRadius = 2.0
        saveTimeZoneButton.layer.shadowOpacity = 0.4
        saveTimeZoneButton.layer.shadowOffset = CGSize(width: 1, height: 2)
        saveTimeZoneButton.layer.cornerRadius = 4
        saveTimeZoneButton.setTitle(String.localize("Сохранить"), for: .normal)
        
        timeZoneDetailsView.layer.cornerRadius = 4
        timeZoneDetailsLabel.text = "UTS:"
    }
    
    
    @IBAction private func timeZoneButtonDidTouchUpInside(_ sender: Any) {
        timeZoneView.isHidden = !timeZoneView.isHidden
        
        let imageName = timeZoneView.isHidden ? "icon_arrowUp" : "icon_bigArrowDown"
        timeZoneArrowImageView.image = UIImage(named: imageName)
    }
    
    @IBAction private func timeZonePickerButtonDidTouchUpInside(_ sender: UIButton) {
        activeButton = sender
        showTimeZonePicker()
    }
    
    @IBAction private func saveTimeZoneButtonDidTouchUpInside(_ sender: Any) {
        view.endEditing(true)
        presenter.uploadTimeZone()
    }
}
