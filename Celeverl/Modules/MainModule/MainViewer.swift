//
import UIKit
import Foundation

class MainViewer: UIViewController, MainViewerProtocol, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: - MainViewerProtocol implementation
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?

    func showError(error: String) {
        self.mainQueue.async {
            self.panel.errorText = error
        }
    }

    func hideError() {
       self.mainQueue.async {
           self.panel.errorText = ""
       }
    }

    func changePhoneField(mobile: String){
        self.mainQueue.async {
            self.panel.placeHolderText = mobile
        }
    }

    func changeCodeCountry(_ countryCode: String){
        self.mainQueue.async {
            self.panel.titleButtonText = countryCode
        }
    }
    
    func changedBusyState(_ state: Bool) {
        self.mainQueue.async {
            self.panel.codeButton.isBusy = state
        }
    }
    
    func updateCountryData(_ data: [CountryCodeModel]) {
        self.mainQueue.async {
            self.dataCountryList = data
            self.customPicker.reloadAllComponents()
        }
    }
    
    func setCurrentCountryData(_ country: CountryCodeModel) {
        self.mainQueue.async {
            self.currentCountry = country
            self.panel.titleButtonText = "+\(country.Code)"
        }
    }
    
    //MARK: - Properrties
    lazy var mainTitle: UILabel = {
        var label = UILabel()
        return label
    }()
    lazy var bottomLayer: CAShapeLayer = {
        var layer = CAShapeLayer()
        return layer
    }()
    lazy var firstTitle: UILabel = {
        var label = UILabel()
        return label
    }()
    lazy var secondTitle: UILabel = {
        var label = UILabel()
        return label
    }()
    lazy var panel: LognInPanel = {
        var panel = LognInPanel()
        return panel
    }()
    lazy var closeButton: AppCustomButton = {
           var close = AppCustomButton()
           close.title = "Отмена"
           close.titleLabel?.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 22)
           close.titleLabel?.textColor = .black
           close.setTitleColor(.black, for: .normal)
           close.backgroundColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
           return close
    }()
    lazy var updateButton: AppCustomButton = {
          var close = AppCustomButton()
          close.title = "Обновить"
          close.titleLabel?.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 22)
          close.titleLabel?.textColor = .black
          close.setTitleColor(.black, for: .normal)
          close.backgroundColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
          return close
    }()
    
    var currentCountry: CountryCodeModel? = nil
    var dataCountryList: [CountryCodeModel] = []

    lazy var customPicker: UIPickerView = {
       let picker = UIPickerView()
       return picker
    }()
    
    lazy var mainQueue = DispatchQueue.main
    lazy var backQueue = DispatchQueue.global(qos: .background)
    
    
    override func loadView(){
        super.loadView()
        self.configureController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor?.loadDefaultData()
        self.registerForKeyboardNotifications()
    }
    
    //MARK: - Configaure Views
    func configureController(){
        self.configuareMainTitle()
        self.configuareFirstTitle()
        self.configuareSecondTitle()
        self.configuareLogInPanel()
        self.configuareDataPicker()
        self.configuareToolbarButtons()
    }

    func configuareMainTitle(){
        let imageLayer = CALayer()
        imageLayer.contents = UIImage(named: "main_picture")?.cgImage
        imageLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.35)
        imageLayer.contentsScale = UIScreen.main.scale
        self.view.layer.addSublayer(imageLayer)

        let radius: CGFloat = 10
        bottomLayer.backgroundColor = UIColor.white.cgColor
        bottomLayer.cornerRadius = radius
        bottomLayer.frame = CGRect(x: 0, y: self.view.frame.height * 0.34 - radius, width: self.view.frame.width, height: self.view.frame.height * 0.7)
        self.view.layer.addSublayer(bottomLayer)

        let applicationName = UILabel()
        applicationName.text = NSLocalizedString("COMPANYTITLE", comment: "")
        applicationName.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 25)
        applicationName.textColor = .white
        applicationName.textAlignment = NSTextAlignment.center
        self.view.addSubview(applicationName)
        applicationName.translatesAutoresizingMaskIntoConstraints = false
        applicationName.topAnchor.constraint(equalTo: self.view.topAnchor, constant: imageLayer.bounds.height * 0.5 - 25).isActive = true
        applicationName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true

        let secondName = UILabel()
        secondName.text = "GENERATION"
        secondName.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 18)
        secondName.textColor = .white
        secondName.textAlignment = NSTextAlignment.center
        self.view.addSubview(secondName)
        secondName.translatesAutoresizingMaskIntoConstraints = false
        secondName.topAnchor.constraint(equalTo: applicationName.bottomAnchor, constant: 0).isActive = true
        secondName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }

    func configuareFirstTitle(){
        
        view.addSubview(self.firstTitle)
        self.firstTitle.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        self.firstTitle.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 25)
        self.firstTitle.text = "Авторизация"
        self.firstTitle.translatesAutoresizingMaskIntoConstraints = false
        self.firstTitle.topAnchor.constraint(equalTo:self.view.topAnchor, constant: self.bottomLayer.frame.minY + self.bottomLayer.bounds.height * 0.05).isActive = true
        self.firstTitle.leftAnchor.constraint(equalTo:
            self.view.leftAnchor , constant: self.bottomLayer.frame.width * 0.1).isActive = true

    }

    func configuareSecondTitle(){
        
        view.addSubview(self.secondTitle)
        self.secondTitle.textColor = UIColor(red: 0.567, green: 0.567, blue: 0.567, alpha: 1)
        self.secondTitle.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 12)
        self.secondTitle.text = "Мы отправим вам смс с кодом доступа"

        self.secondTitle.translatesAutoresizingMaskIntoConstraints = false
        self.secondTitle.topAnchor.constraint(equalTo:firstTitle.bottomAnchor, constant: 0).isActive = true
        self.secondTitle.leftAnchor.constraint(equalTo:
        self.view.leftAnchor , constant: self.bottomLayer.frame.width * 0.1).isActive = true
    }

    func configuareLogInPanel(){
        self.view.addSubview(panel)

        panel.titleText = "Ваш телефон:"
        panel.placeHolderText = "Номер телефона"
        panel.codeButton.title = "Отправить код"
        panel.errorText = ""

        panel.translatesAutoresizingMaskIntoConstraints = false
        panel.topAnchor.constraint(equalTo: self.secondTitle.bottomAnchor, constant: self.view.frame.height * 0.05).isActive = true
        panel.leftAnchor.constraint(equalTo:
        self.view.leftAnchor , constant: self.bottomLayer.frame.width * 0.1).isActive = true
        panel.rightAnchor.constraint(equalTo:
        self.view.rightAnchor , constant: -self.bottomLayer.frame.width * 0.1).isActive = true
        panel.heightAnchor.constraint(equalToConstant: 270).isActive = true
        panel.field.delegate = self
        panel.field.keyboardType = .phonePad
        panel.codeButton.Action = {(button) in
            self.interactor?.checkPhone()
        }
        panel.field.addTarget(self, action: #selector(changedPhoneField), for: .editingChanged)
        panel.button.Action = {(_) in
            self.showPicker()
        }
        let tapRecognizier = UITapGestureRecognizer(target: self, action: #selector(openAgreementView))
        panel.agreementTitleView.addGestureRecognizer(tapRecognizier)
    }
    
    
    @objc private func openAgreementView(){
        self.interactor?.openAgreement()
    }
    
    private func configuareToolbarButtons(){
           
       self.view.addSubview(self.closeButton)
       
       self.closeButton.translatesAutoresizingMaskIntoConstraints = false
       self.closeButton.bottomAnchor.constraint(equalTo: self.customPicker.topAnchor, constant: 0).isActive = true
       self.closeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
       self.closeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
       self.closeButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
       self.closeButton.isHidden = true
       self.closeButton.Action = {(_) in
           self.closePicker()
       }
       
       self.view.addSubview(self.updateButton)
       self.updateButton.translatesAutoresizingMaskIntoConstraints = false
       self.updateButton.bottomAnchor.constraint(equalTo: self.customPicker.topAnchor, constant: 0).isActive = true
       self.updateButton.leftAnchor.constraint(equalTo: self.closeButton.rightAnchor, constant: 0).isActive = true
       self.updateButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
       self.updateButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
       self.updateButton.isHidden = true
       self.updateButton.Action = {(_) in
           self.updateData()
       }
    }
    
    private func configuareDataPicker(){
        
        self.view.addSubview(self.customPicker)
        self.customPicker.translatesAutoresizingMaskIntoConstraints = false
        
        self.customPicker.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.customPicker.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.customPicker.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.customPicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.customPicker.backgroundColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        self.customPicker.tintColor = .white
        self.customPicker.dataSource = self
        self.customPicker.delegate = self
        self.customPicker.isHidden = true
        
    }
    
   
    private func showPicker(){
       self.customPicker.isHidden = false
       self.closeButton.isHidden = false
       self.updateButton.isHidden = false
    }
    
    private func updateData(){
        self.closePicker()
        guard let country = self.currentCountry else { return }
        self.interactor?.changeCountry(country)
        self.panel.titleButtonText = "+\(country.Code)"
    }
    
    private func closePicker(){
        self.customPicker.isHidden = true
        self.closeButton.isHidden = true
        self.updateButton.isHidden = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    
    //MARK: - data picker functions
    
    @objc func changedPhoneField(textField: UITextField) {
       let text = textField.text!
       self.interactor?.changePhoneFeild(string: text)
    }


    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return self.dataCountryList.count
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       let index = row
       self.currentCountry = self.dataCountryList[index]
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
      
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
       
       let label = UILabel()
       label.font = UIFont(name: AppConstants.APP_ROBOTO_REGULAR, size: 25)
       label.textColor = .black
       label.textAlignment = .center
       
       if self.dataCountryList.count > 0 {
           label.text = "\(self.dataCountryList[row].Title) +\(self.dataCountryList[row].Code)"
       }
       return label
    }
      
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
       return 70
    }
    
    
    //MARK: - TextField functions
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

    @objc func handleKeyboardNotification( notification: NSNotification){
       
       var pointY:CGFloat = 0.0
       
       if notification.name == UIResponder.keyboardWillShowNotification, let userInfo = notification.userInfo {
            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            pointY = -frame.height
       }
       else if notification.name == UIResponder.keyboardWillHideNotification {
           pointY = 0
       }
       
       UIView.animate(withDuration: 0.2, animations: {
           self.view.frame.origin.y = pointY
       })
    }

    func registerForKeyboardNotifications(){
       NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unregisterForKeyboardNotifications(){
       NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
       NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }


    deinit {
       self.unregisterForKeyboardNotifications()
    }
   
}
