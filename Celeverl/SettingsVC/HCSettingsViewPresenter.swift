//
//  HCSettingsViewPresenter.swift
//  HappyChild (mobile)
//
//  Created by Anna on 15.12.2019.
//  Copyright © 2019 oberon. All rights reserved.
//

import UIKit

protocol HCSettingsViewPresenterProtocol {
    var balance: Int { get }
    var timeZone: Int { get set }
    var isCameraAvailable: Bool { get set }
    var isCameraActive: Bool { get }
    var cameraMode: Int? { get set }
    var isWholeDay: Bool { get set }
    var startHour: Int { get set }
    var endHour: Int { get set }
    var startDate: Date? { get set }
    var endDate: Date? { get set }
    var shouldShowSelectionDayView: Bool { get }
    var shouldShowSelectionDateView: Bool { get }
    
    
    func loadSettings()
    func uploadTimeZone()
    func uploadCameraStatus()
    func uploadCameraSettings()
    func updateSelectedDays(with index: Int)
    func isDaySelectedByIndex(_ dayIndex: Int) -> Bool
}

class HCSettingsViewPresenter: NSObject {
    
    unowned private var view: HCSettingsViewControllerProtocol
    private var model: HCSettingsViewModel
    private var networkService: HCNetworkService
    
    init(view: HCSettingsViewControllerProtocol, model: HCSettingsViewModel) {
        self.view = view
        self.model = model
        self.networkService = HCNetworkService()
    }
    
    private func loadUserSettings() {
        let userId = AccountService.shared.currentAccount?.Id ?? "" // UserDefaults.standard.value(forKey: "userId") as! String
        
        view.showActivityIndicator(true)
        
        networkService.loadSettingsForUser(userId) { [weak self] (response, error) in
            if let response = response {
                self?.model.balance = response.balance ?? 0
                self?.model.timeZone = response.timeZone ?? 0
                self?.model.isCameraAvailable = (response.camera != nil) ? true : false
                
                if (self?.model.isCameraAvailable != nil && self!.model.isCameraAvailable) {
                    self?.model.camera = response.camera
                }
                
                self?.view.updateUI()
                self?.view.showActivityIndicator(false)
            }
            
            if ((error) != nil) {
                self?.view.showActivityIndicator(false)
                print(error!)
            }
        }
    }
    
    private func uploadUserTimeZone() {
        let userId = AccountService.shared.currentAccount?.Id ?? "" // UserDefaults.standard.value(forKey: "userId") as! String
        view.showActivityIndicator(true)
        
        networkService.uploadTimeZoneForUser(userId, timeZone: model.timeZone) { [weak self] (success, error) in
            if (success) {
                self?.view.showActivityIndicator(false)
            }
            if (error != nil) {
                self?.view.showActivityIndicator(false)
            }
        }
    }
    
    private func uploadUserCameraStatus() {
        let userId = AccountService.shared.currentAccount?.Id ?? ""// UserDefaults.standard.value(forKey: "userId") as! String
        view.showActivityIndicator(true)
        
        networkService.uploadCameraStatusForUser(userId, status: model.isCameraAvailable) { [weak self] (success, error) in
            if (success) {
                self?.view.showActivityIndicator(false)
            }
            if (error != nil) {
                self?.view.showActivityIndicator(false)
            }
        }
    }
    
    private func uploadUserCameraSettings() {
        let userId = AccountService.shared.currentAccount?.Id ?? "" // UserDefaults.standard.value(forKey: "userId") as! String
        view.showActivityIndicator(true)
        
        networkService.uploadCameraSettingsForUser(userId, settings: model.camera!) { [weak self] (success, error) in
            if (success) {
                self?.view.showActivityIndicator(false)
            }
            if (error != nil) {
                self?.view.showActivityIndicator(false)
            }
        }
        
        
    }
    
    private func updateSettingsForWorkDays() {
        model.camera!.selectedDays = [HCDays.allCases.lastIndex(of: .monday)!,
                                      HCDays.allCases.lastIndex(of: .tuesday)!,
                                      HCDays.allCases.lastIndex(of: .wednesday)!,
                                      HCDays.allCases.lastIndex(of: .thursday)!,
                                      HCDays.allCases.lastIndex(of: .friday)!]
        model.camera!.endDate = nil
        model.camera!.startDate = nil
        model.shouldShowSelectionDayView = false
        model.shouldShowSelectionDateView = false
    }
    
    private func updateSettingsForCertainDays() {
        model.shouldShowSelectionDayView = true
        model.shouldShowSelectionDateView = false
        
        model.camera!.endDate = nil
        model.camera!.startDate = nil
    }
    
    private func updateSettingsForInterval() {
        model.camera!.selectedDays = nil
        model.shouldShowSelectionDayView = false
        model.shouldShowSelectionDateView = true
        
        if (model.camera!.startDate == nil) {
            model.camera!.startDate = Date()
        }
        
        if (model.camera!.endDate == nil) {
            model.camera!.endDate = Date().dayAfter
        }
    }
    
    private func updateSettingsForEveryDay() {
        model.shouldShowSelectionDayView = false
        model.shouldShowSelectionDateView = false
        
        model.camera!.selectedDays = [HCDays.allCases.lastIndex(of: .monday)!,
                                      HCDays.allCases.lastIndex(of: .tuesday)!,
                                      HCDays.allCases.lastIndex(of: .wednesday)!,
                                      HCDays.allCases.lastIndex(of: .thursday)!,
                                      HCDays.allCases.lastIndex(of: .friday)!,
                                      HCDays.allCases.lastIndex(of: .saturday)!,
                                      HCDays.allCases.lastIndex(of: .sunday)!]
        model.camera!.endDate = nil
        model.camera!.startDate = nil
    }
    
    private func updateSettingsForWeekend() {
        model.shouldShowSelectionDayView = false
        model.shouldShowSelectionDateView = false
        
        model.camera!.selectedDays = [HCDays.allCases.lastIndex(of: .saturday)!,
                                      HCDays.allCases.lastIndex(of: .sunday)!]
        model.camera!.endDate = nil
        model.camera!.startDate = nil
    }
    
    private func updateSettingsForCurrentCameraMode() {
        guard model.camera != nil else {
            return
        }
        
        switch model.camera?.type! {
        case .workDays:
            updateSettingsForWorkDays()
        case .certainDays:
            updateSettingsForCertainDays()
        case .interval:
            updateSettingsForInterval()
        case .everyDay:
            updateSettingsForEveryDay()
        case .weekend:
            updateSettingsForWeekend()
        default:
            return
        }
        
        view.updateSettingsViews()
    }
}

extension HCSettingsViewPresenter: HCSettingsViewPresenterProtocol {
    
    func updateSelectedDays(with index: Int) {
        
        guard model.camera != nil else {
            return
        }
        
        if (model.camera!.selectedDays != nil && model.camera!.selectedDays!.contains(index)) {
            let dayIndex = model.camera!.selectedDays!.lastIndex(of: index)!
            model.camera!.selectedDays?.remove(at: dayIndex)
        } else if (model.camera!.selectedDays == nil) {
            model.camera!.selectedDays = [Int]()
            model.camera!.selectedDays?.append(index)
        } else {
            model.camera!.selectedDays?.append(index)
            model.camera!.selectedDays?.sort()
        }
    }
    
    func isDaySelectedByIndex(_ dayIndex: Int) -> Bool {
        var isSelected = false
        
        if (model.camera != nil && model.camera!.selectedDays != nil) {
            isSelected = model.camera!.selectedDays!.contains(dayIndex)
        }
        
        return isSelected
    }
    
    var shouldShowSelectionDayView: Bool {
        return model.shouldShowSelectionDayView
    }
    
    var shouldShowSelectionDateView: Bool {
        return model.shouldShowSelectionDateView
    }
    
    
    var endHour: Int {
        get {
            return model.camera?.endHour ?? 24
        }
        set {
            model.camera?.endHour = newValue
        }
    }
    
    
    var startHour: Int {
        get {
            return model.camera?.startHour ?? 0
        }
        set {
            model.camera?.startHour = newValue
        }
    }
    
    var balance: Int {
        return model.balance
    }
    
    var timeZone: Int {
        get {
            return model.timeZone
        }
        set {
            model.timeZone = newValue
        }
    }
    
    var isCameraAvailable: Bool {
        get {
            return model.isCameraAvailable
        }
        set {
            model.isCameraAvailable = newValue
        }
    }
    
    var cameraMode: Int? {
        get {
            return HCCameraMode.allCases.lastIndex(of: model.camera?.type! ?? .workDays)
        }
        set {
            model.camera?.type = HCCameraMode.allCases[newValue!]
            updateSettingsForCurrentCameraMode()
        }
    }
    
    var isWholeDay: Bool {
        set {
            model.camera?.isForWholeDay = newValue
            if (newValue) {
                model.camera?.startHour = 0
                model.camera?.endHour = 24
            }
        }
        get {
            return model.camera?.isForWholeDay ?? false
        }
    }
    
    var isCameraActive: Bool {
        return model.camera?.isActive ?? false
    }
    
    var startDate: Date? {
        set {
            model.camera!.startDate = newValue
            view.updateDateSelectionView()
        }
        get {
            return model.camera!.startDate
        }
    }
    
    var endDate: Date? {
        set {
            model.camera!.endDate = newValue
            view.updateDateSelectionView()
        }
        get {
            return model.camera!.endDate
        }
    }
    
    func loadSettings() {
        loadUserSettings()
    }
    
    func uploadTimeZone() {
        uploadUserTimeZone()
    }
    
    func uploadCameraStatus() {
        uploadUserCameraStatus()
    }
    
    func uploadCameraSettings() {
        uploadUserCameraSettings()
    }
}
