//
//  HCSettingsViewController + CameraHours.swift
//  HappyChild (mobile)
//
//  Created by Anna on 17.12.2019.
//  Copyright © 2019 oberon. All rights reserved.
//

import Foundation
import UIKit

extension HCSettingsViewController {
     
    func setupCameraHoursView() {
        cameraHoursView.isHidden = true
        
        cameraHoursTitleLabel.text = String.localize("Выберите часы работы:")
        
        saveSettingsButton.layer.masksToBounds = false
        saveSettingsButton.layer.shadowRadius = 2.0
        saveSettingsButton.layer.shadowOpacity = 0.4
        saveSettingsButton.layer.shadowOffset = CGSize(width: 1, height: 2)
        saveSettingsButton.layer.cornerRadius = 4
        saveSettingsButton.setTitle(String.localize("Сохранить"), for: .normal)
        
        allDayLabel.text = String.localize("Весь день")
        startHourTitleLabel.text = String.localize("c")
        startHourLabel.text = ""
        
        startHourView.layer.borderColor = UIColor.customLightGray().cgColor
        startHourView.layer.borderWidth = 2
        startHourView.layer.cornerRadius = 10
        
        endHourTitleLabel.text = String.localize("до")
        endHourLabel.text = ""
        
        endHourView.layer.borderColor = UIColor.customLightGray().cgColor
        endHourView.layer.borderWidth = 2
        endHourView.layer.cornerRadius = 10
    }
    
    
    
    @IBAction func endHourLabelDidTouchUpInside(_ sender: UIButton) {
        activeButton = sender
        showEndTimePicker()
    }

    @IBAction func startHourButtonDidTouchUpInside(_ sender: UIButton) {
        activeButton = sender
        showStartTimePicker()
    }

    @IBAction func allDayCheckboxButtonDidTouchUpInside(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        let imageName = sender.isSelected ? "icon_selectedCheckbox" : "icon_deselectedCheckbox"
        sender.setImage(UIImage(named: imageName), for: .normal)
        
        presenter.isWholeDay = sender.isSelected
        
        startHourView.isUserInteractionEnabled = !presenter.isWholeDay
        endHourView.isUserInteractionEnabled = !presenter.isWholeDay
        
        startHourLabel.text = "\(presenter.startHour)"
        endHourLabel.text = "\(presenter.endHour)"

    }
    
    @IBAction func saveSettingsButtonDidTouchUpInside(_ sender: Any) {
        presenter.uploadCameraSettings()
    }
}


