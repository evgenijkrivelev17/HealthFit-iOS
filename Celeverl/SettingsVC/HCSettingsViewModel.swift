//
//  HCSettingsViewModel.swift
//  HappyChild (mobile)
//
//  Created by Anna on 15.12.2019.
//  Copyright © 2019 oberon. All rights reserved.
//

import UIKit

class HCSettingsViewModel: NSObject {
    var balance: Int = 0
    var timeZone: Int = 0
    
    var isCameraAvailable = false
    var shouldShowSelectionDayView = false
    var shouldShowSelectionDateView = false

    var camera: HCCameraSettingsModel?
}
