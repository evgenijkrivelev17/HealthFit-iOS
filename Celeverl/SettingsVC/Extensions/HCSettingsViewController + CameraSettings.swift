//
//  HCSettingsViewController + CameraSettings.swift
//  HappyChild (mobile)
//
//  Created by Anna on 17.12.2019.
//  Copyright © 2019 oberon. All rights reserved.
//

import Foundation
import UIKit

extension HCSettingsViewController {
    
    func setupCameraSettingsViews() {
        
        showCameraSettingsButton.isUserInteractionEnabled = presenter.isCameraAvailable
        cameraSettingsTitleView.alpha = presenter.isCameraAvailable ? 1 : 0.3
        cameraSettingsImageView.image = UIImage(named: "icon_arrowUp")
        cameraSettingsTitleLabel.text = String.localize("Режим работы камер:")
        
        cameraSettingsView.isHidden = true
        
        for button in cameraSettingsCheckBoxButtons {
            let image = UIImage(named: "icon_deselectedCircle")
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(checkBoxButtonDidTouchUpInside(_:)), for: .touchUpInside)
        }
        
        checkBoxButtonDidTouchUpInside(cameraSettingsCheckBoxButtons[presenter.cameraMode!])
        
        for (index, label) in cameraSettingsTypeLabels.enumerated() {
            guard HCCameraMode.allCases.count > index else {
                return
            }
            
            let text = HCCameraMode.allCases[index].rawValue
            label.text = String.localize(text)
        }

    }
    
    @IBAction func showCameraSettingsButtonDidTouchUpInside(_ sender: Any) {
        cameraSettingsView.isHidden = !cameraSettingsView.isHidden
        cameraHoursView.isHidden = cameraSettingsView.isHidden
        
        daySelectionView.isHidden = !presenter.shouldShowSelectionDayView
        dateSelectionView.isHidden = !presenter.shouldShowSelectionDateView

        let imageName = cameraSettingsView.isHidden ? "icon_arrowUp" : "icon_bigArrowDown"
        cameraSettingsImageView.image = UIImage(named: imageName)
    }
    
    @objc func checkBoxButtonDidTouchUpInside(_ sender: UIButton) {
        sender.isSelected = true
        
        let otherButtons = cameraSettingsCheckBoxButtons.filter { $0 != sender }
       
        for button in otherButtons {
            button.isSelected = false
            button.setImage(UIImage(named: "icon_deselectedCircle"), for: .normal)
        }
        
        sender.setImage(UIImage(named: "icon_selectedCircle"), for: .normal)
        
        presenter.cameraMode = cameraSettingsCheckBoxButtons.lastIndex(of: sender)!
    }
    
}
