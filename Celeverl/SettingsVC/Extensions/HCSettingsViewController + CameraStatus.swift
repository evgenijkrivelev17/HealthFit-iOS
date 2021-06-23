//
//  HCSettingsViewController + CameraStatus.swift
//  HappyChild (mobile)
//
//  Created by Anna on 15.12.2019.
//  Copyright © 2019 oberon. All rights reserved.
//

import UIKit

extension HCSettingsViewController {
    
    func setupCameraStatusViews() {
        showCameraStatusButton.isUserInteractionEnabled = presenter.isCameraAvailable
        cameraStatusTitleLabel.alpha = presenter.isCameraAvailable ? 1 :0.3
        cameraStatusArrowImageView.alpha = presenter.isCameraAvailable ? 1 :0.3
        
        cameraStatusTitleLabel.text = String.localize("Статус камер:")
        cameraStatusArrowImageView.image = UIImage(named: "icon_arrowUp")
        
        cameraStatusView.isHidden = true
        cameraStatusViewTitleLabel.text = String.localize("Камеры включены")
        
        saveCameraStatusButton.layer.masksToBounds = false
        saveCameraStatusButton.layer.shadowRadius = 2.0
        saveCameraStatusButton.layer.shadowOpacity = 0.4
        saveCameraStatusButton.layer.shadowOffset = CGSize(width: 1, height: 2)
        saveCameraStatusButton.layer.cornerRadius = 4
        saveCameraStatusButton.setTitle(String.localize("Сохранить"), for: .normal)
        
        cameraStatusSwitch.isSelected = presenter.isCameraActive
    }
    
    @IBAction func cameraStatusButtonDidTouchUpInside(_ sender: Any) {
        cameraStatusView.isHidden = !cameraStatusView.isHidden
        
        let imageName = cameraStatusView.isHidden ? "icon_arrowUp" : "icon_bigArrowDown"
        cameraStatusArrowImageView.image = UIImage(named: imageName)
    }
    
    @IBAction func saveCameraStatusButtonDidTouchUpInside(_ sender: Any) {
        presenter.uploadCameraStatus()
    }
    
    @IBAction func cameraStarusSwitchDidChangeValue(_ sender: Any) {
        presenter.isCameraAvailable = cameraStatusSwitch.isSelected
    }
}
