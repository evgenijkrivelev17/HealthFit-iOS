//
//  HCSettingsViewController.swift
//  HappyChild (mobile)
//
//  Created by Anna on 10.12.2019.
//  Copyright © 2019 oberon. All rights reserved.
//

import UIKit
import PVSwitch
import MaterialComponents.MaterialActivityIndicator

protocol HCSettingsViewControllerProtocol: AnyObject {
    func updateUI()
    func showActivityIndicator(_ show: Bool)
    func updateTimeZoneViews()
    func updateCameraStatus()
    func updateBalace()
    func updateCameraSettings()
    func updateCameraHoursView()
    func updateSettingsViews()
    func updateDateSelectionView()
    func updateDaySelectionView()
}

class HCSettingsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var balanceTitleLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var editTextField: UITextField!
    
    @IBOutlet weak var timeZoneTitleLabel: UILabel!
    @IBOutlet weak var timeZoneArrowImageView: UIImageView!
    @IBOutlet weak var timeZoneView: UIView!
    @IBOutlet weak var timeZoneViewTitleLabel: UILabel!
    @IBOutlet weak var saveTimeZoneButton: UIButton!
    @IBOutlet weak var timeZoneDetailsView: UIView!
    @IBOutlet weak var timeZoneDetailsLabel: UILabel!
    
    @IBOutlet weak var cameraStatusTitleLabel: UILabel!
    @IBOutlet weak var cameraStatusArrowImageView: UIImageView!
    @IBOutlet weak var showCameraStatusButton: UIButton!
    @IBOutlet weak var cameraStatusView: UIView!
    @IBOutlet weak var cameraStatusViewTitleLabel: UILabel!
    @IBOutlet weak var saveCameraStatusButton: UIButton!
    @IBOutlet weak var cameraStatusSwitch: PVSwitch!
    
    @IBOutlet weak var cameraSettingsTitleView: UIView!
    @IBOutlet weak var showCameraSettingsButton: UIButton!
    @IBOutlet weak var cameraSettingsImageView: UIImageView!
    @IBOutlet weak var cameraSettingsTitleLabel: UILabel!
    @IBOutlet weak var cameraSettingsView: UIView!
    @IBOutlet var cameraSettingsCheckBoxButtons: [UIButton]!
    @IBOutlet var cameraSettingsTypeLabels: [UILabel]!
    
    @IBOutlet weak var cameraHoursView: UIView!
    @IBOutlet weak var cameraHoursTitleLabel: UILabel!
    @IBOutlet weak var saveSettingsButton: UIButton!
    @IBOutlet weak var allDayCheckboxButton: UIButton!
    @IBOutlet weak var allDayLabel: UILabel!
    @IBOutlet weak var startHourTitleLabel: UILabel!
    @IBOutlet weak var startHourLabel: UILabel!
    @IBOutlet weak var startHourView: UIView!
    @IBOutlet weak var endHourTitleLabel: UILabel!
    @IBOutlet weak var endHourView: UIView!
    @IBOutlet weak var endHourLabel: UILabel!
    
    @IBOutlet weak var daySelectionView: UIView!
    @IBOutlet weak var daySelectionTitleLabel: UILabel!
    @IBOutlet var daySelectionButtons: [UIButton]!
    @IBOutlet var daySelectionLabels: [UILabel]!
    
    @IBOutlet weak var dateSelectionView: UIView!
    @IBOutlet weak var dateSelectionTitleLabel: UILabel!
    @IBOutlet weak var dateSelectionBackView: UIView!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: MDCActivityIndicator!
    
    
    var presenter: HCSettingsViewPresenterProtocol!
    var activeButton: UIButton?
    
    var scrollOffset : CGFloat = 0
    var distance : CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPresenter()
        setupUI()
//        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.loadSettings()
        registerKeyboardNotifications()
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillShow(notification:)),
                                             name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillHide(notification:)),
                                             name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
       if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            var safeArea = self.view.frame
            safeArea.size.height -= keyboardSize.height + (UIScreen.main.bounds.height*0.04)
            
            if let activeButton = activeButton {
                if safeArea.contains(CGPoint(x: 0, y: activeButton.superview!.convert(activeButton.frame.origin, to: view).y)) {
                    print("No need to Scroll")
                    return
                } else {
                    distance = activeButton.superview!.convert(activeButton.frame.origin, to: view).y - safeArea.size.height + 50
                    scrollOffset = scrollView.contentOffset.y
                    self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffset + distance), animated: true)
                }
            }
            // prevent scrolling while typing

            
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if distance == 0 {
            return
        }
        // return to origin scrollOffset
        self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffset), animated: true)
        scrollOffset = 0
        distance = 0
        scrollView.isScrollEnabled = true
        activeButton = nil
    }
    
    //MARK: - Setups
    
    private func setupPresenter() {
        let model = HCSettingsViewModel()
        let presenter = HCSettingsViewPresenter(view: self, model: model)
        
        self.presenter = presenter
    }
    
    private func setupUI() {
        titleLabel.text = String.localize("Настройки профиля:")
        
        activityIndicator.cycleColors = [UIColor.activityIndicatorColor()]
        
        setupTimeZoneViews()
        setupBalanceView()
        setupCameraStatusViews()
        setupCameraSettingsViews()
        setupCameraHoursView()
        setupDaySelectionView()
        setupDateSelectionView()
        
        scrollView.isScrollEnabled = false
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        scrollView.addGestureRecognizer(gesture)
    }
    
    private func setupBalanceView() {
        balanceView.layer.cornerRadius = 10
        balanceTitleLabel.text = String.localize("Баланс:")
        balanceLabel.text = "\(presenter.balance)"
    }
    
}

extension HCSettingsViewController: HCSettingsViewControllerProtocol {
    
    func updateUI() {
        updateBalace()
        updateCameraStatus()
        updateTimeZoneViews()
        updateCameraSettings()
        updateCameraHoursView()
        updateDateSelectionView()
        updateDaySelectionView()
    }
    
    func showActivityIndicator(_ show: Bool) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = !show
            self.activityIndicator.startAnimating()
        }
    }
    
    func updateTimeZoneViews() {
        DispatchQueue.main.async {
            self.timeZoneDetailsLabel.text = "UTS:" + ((self.presenter.timeZone > 0) ? "+\(self.presenter.timeZone)" : "\(self.presenter.timeZone)")
        }
    }
    
    func updateCameraStatus() {
        DispatchQueue.main.async {
            self.cameraStatusSwitch.isSelected = self.presenter.isCameraActive
            
            self.showCameraStatusButton.isUserInteractionEnabled = self.presenter.isCameraAvailable
            self.cameraStatusTitleLabel.alpha = self.presenter.isCameraAvailable ? 1 :0.3
            self.cameraStatusArrowImageView.alpha = self.presenter.isCameraAvailable ? 1 :0.3
            
            let imageName = self.cameraStatusView.isHidden ? "icon_arrowUp" : "icon_bigArrowDown"
            self.cameraStatusArrowImageView.image = UIImage(named: imageName)
            
            if (!self.presenter.isCameraAvailable && !self.cameraStatusView.isHidden) {
                self.cameraStatusView.isHidden = true
            }
        }
    }
    
    func updateCameraSettings() {
        DispatchQueue.main.async {
            self.showCameraSettingsButton.isUserInteractionEnabled = self.presenter.isCameraAvailable
            self.cameraSettingsTitleView.alpha = self.presenter.isCameraAvailable ? 1 : 0.3
            
            let imageName = self.cameraSettingsView.isHidden ? "icon_arrowUp" : "icon_bigArrowDown"
            self.cameraSettingsImageView.image = UIImage(named: imageName)
            
            if (!self.presenter.isCameraAvailable && !self.cameraSettingsView.isHidden) {
                self.cameraSettingsView.isHidden = true
            }
            self.checkBoxButtonDidTouchUpInside(self.cameraSettingsCheckBoxButtons[self.presenter.cameraMode!])
        }
    }
    
    func updateSettingsViews() {
        DispatchQueue.main.async {
            if (!self.cameraSettingsView.isHidden) {
                self.daySelectionView.isHidden = !self.presenter.shouldShowSelectionDayView
                self.dateSelectionView.isHidden = !self.presenter.shouldShowSelectionDateView
            }
        }
    }
    
    func updateBalace() {
        DispatchQueue.main.async {
            self.balanceLabel.text = "\(self.presenter.balance)"
        }
    }
    
    func updateCameraHoursView() {
        DispatchQueue.main.async {
            let imageName = self.presenter.isWholeDay ? "icon_selectedCheckbox" : "icon_deselectedCheckbox"
            self.allDayCheckboxButton.setImage(UIImage(named: imageName), for: .normal)
            self.allDayCheckboxButton.isSelected = self.presenter.isWholeDay
            
            self.startHourLabel.text = "\(self.presenter.startHour)"
            self.endHourLabel.text = "\(self.presenter.endHour)"
            
            self.startHourView.isUserInteractionEnabled = !self.presenter.isWholeDay
            self.endHourView.isUserInteractionEnabled = !self.presenter.isWholeDay
        }
    }
    
    func updateDaySelectionView() {
        DispatchQueue.main.async {
            for button in self.daySelectionButtons {
                let index = self.daySelectionButtons.lastIndex(of: button)!
                button.isSelected = self.presenter.isDaySelectedByIndex(index)
                
                let imageName = button.isSelected ? "icon_selectedCheckbox" : "icon_deselectedCheckbox"
                button.setImage(UIImage(named: imageName), for: .normal)
                
            }
        }
    }
    
    func updateDateSelectionView() {
        DispatchQueue.main.async {
            self.startDateLabel.text = Date.stringFrom(date: self.presenter.startDate ?? Date())
            self.endDateLabel.text = Date.stringFrom(date: self.presenter.endDate ?? Date().dayAfter)
        }
    }
    
    @objc func hideKeyboard(_ gestire: UIGestureRecognizer) {
        self.view.endEditing(true)
    }

}
