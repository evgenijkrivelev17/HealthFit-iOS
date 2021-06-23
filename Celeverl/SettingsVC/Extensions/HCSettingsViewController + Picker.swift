//
//  HCSettingsViewController + Picker.swift
//  HappyChild (mobile)
//
//  Created by Anna on 15.12.2019.
//  Copyright © 2019 oberon. All rights reserved.
//

import Foundation
import UIKit

private let kPickerViewHeight: CGFloat = 240.0

extension HCSettingsViewController {
    
    func showPicker(_ pickerView: UIPickerView) {
        let customView:UIView = UIView (frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: kPickerViewHeight))
        customView.backgroundColor = UIColor.white
        customView.addSubview(pickerView)
        
        editTextField.inputView = customView
        editTextField.becomeFirstResponder()
    }
    
    func showDatePicker(_ pickerView: UIDatePicker) {
        let customView:UIView = UIView (frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: kPickerViewHeight))
        customView.backgroundColor = UIColor.white
        customView.addSubview(pickerView)
        
        editTextField.inputView = customView
        editTextField.becomeFirstResponder()
    }
    
    func showTimeZonePicker() {
        let timeZonePicker = HCTimeZonePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: kPickerViewHeight))
        
        timeZonePicker.timeZones = Array(-12...12)
        timeZonePicker.currentTimeZone = presenter.timeZone
        
        timeZonePicker.onTimeZoneSelected = { (zone: Int) in
            
            self.presenter.timeZone = zone
            self.updateTimeZoneViews()
        }
        
        showPicker(timeZonePicker)
    }
    
    func showStartTimePicker() {
        let taskTimePicker = HCTaskTimePickerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: kPickerViewHeight))
        
        let taskTimes = Array(0...23)

        taskTimePicker.taskTimes = taskTimes
        taskTimePicker.currentTaskTime = presenter.startHour

        taskTimePicker.onTaskTimeSelected = { [weak self] (time: Int) in
            self?.presenter.startHour = time
            
            guard self != nil else {
                return
            }
            
            if (self!.presenter.startHour >= self!.presenter.endHour) {
                self!.presenter.endHour = time + 1
            }
            
            self!.updateCameraHoursView()
        }
        
        showPicker(taskTimePicker)
    }
    
    func showEndTimePicker() {
        let taskTimePicker = HCTaskTimePickerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: kPickerViewHeight))
        
        let taskTimes = Array((presenter.startHour + 1)...24)

        taskTimePicker.taskTimes = taskTimes
        taskTimePicker.currentTaskTime = presenter.endHour

        taskTimePicker.onTaskTimeSelected = { [weak self] (time: Int) in
            self?.presenter.endHour = time
            self?.updateCameraHoursView()
        }
        
        showPicker(taskTimePicker)
    }
    
    func showStartDatePicker() {
        let startDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: kPickerViewHeight))
        
        startDatePicker.datePickerMode = .date
        startDatePicker.minimumDate = Date()
        startDatePicker.setDate(presenter.startDate ?? Date(), animated: true)
        
        startDatePicker.addTarget(self, action: #selector(startDatePickerDidChangeValue(_:)), for: .valueChanged)
        
        showDatePicker(startDatePicker)
    }
    
    func showEndDatePicker() {
        let endDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: kPickerViewHeight))
        
        endDatePicker.datePickerMode = .date
        endDatePicker.minimumDate = presenter.startDate?.dayAfter ?? Date().dayAfter
        endDatePicker.setDate(presenter.endDate ?? Date().dayAfter, animated: true)
        
        endDatePicker.addTarget(self, action: #selector(endDatePickerDidChangeValue(_:)), for: .valueChanged)
        
        showDatePicker(endDatePicker)
    }
    
    @objc func startDatePickerDidChangeValue(_ sender: UIDatePicker) {
        presenter.startDate = sender.date
        
        guard presenter.endDate != nil else {
            presenter.endDate = presenter.startDate?.dayAfter
            return
        }
        
        if (presenter.startDate! >= presenter.endDate!) {
            presenter.endDate = presenter.startDate?.dayAfter
        }
    }
    
    @objc func endDatePickerDidChangeValue(_ sender: UIDatePicker) {
        presenter.endDate = sender.date
    }
}
