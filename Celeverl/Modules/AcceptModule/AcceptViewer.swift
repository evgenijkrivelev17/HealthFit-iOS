import UIKit

//MARK: - AcceptViewer
class AcceptViewer: UIViewController, AcceptViewerProtocol, UITextFieldDelegate {
    
    lazy var mainTitle: UILabel = {
        var label = UILabel()
        return label
    }()
    lazy var bottomLayer: CALayer = {
        var layer = CAShapeLayer()
        return layer
    }()
    lazy var firstTitle: UILabel  = {
           var label = UILabel()
           return label
    }()
    lazy var secondTitle: UILabel  = {
           var label = UILabel()
           return label
    }()
    
    lazy var backView: UIImageView = {
        var image = UIImageView(image: UIImage(named: "arrow_back"))
        return image
    }()
    
    lazy var panel: AppAcceptCodePanel = {
        var panel = AppAcceptCodePanel()
        return panel
    }()
    
    override func loadView() {
        super.loadView()
        self.configuareController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerForKeyboardNotifications()
    }

    func configuareController(){
        self.createMainTitle()
        self.createFirstTitleView()
        self.createLogInPanelView()
    }
    
    func createMainTitle(){
        let imageLayer = CALayer()
        imageLayer.contents = UIImage(named: "main_picture")?.cgImage
        imageLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.35)
        imageLayer.contentsScale = UIScreen.main.scale
        self.view.layer.addSublayer(imageLayer)
        
        let radius: CGFloat = 10
        self.bottomLayer.backgroundColor = UIColor.white.cgColor
        self.bottomLayer.cornerRadius = radius
        self.bottomLayer.frame = CGRect(x: 0, y: self.view.frame.height * 0.34 - radius, width: self.view.frame.width, height: self.view.frame.height * 0.7)
        self.view.layer.addSublayer(self.bottomLayer)
        
        let topTextLayer = UILabel()
        topTextLayer.text = "HappyChild"
        topTextLayer.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 25)
        topTextLayer.textColor = .white
        topTextLayer.textAlignment = NSTextAlignment.center
        self.view.addSubview(topTextLayer)
        topTextLayer.translatesAutoresizingMaskIntoConstraints = false
        topTextLayer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: imageLayer.bounds.height * 0.5 - 25).isActive = true
        topTextLayer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
        let bottomTextLayer = UILabel()
        bottomTextLayer.text = "GENERATION"
        bottomTextLayer.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 18)
        bottomTextLayer.textColor = .white
        bottomTextLayer.textAlignment = NSTextAlignment.center
        self.view.addSubview(bottomTextLayer)
        bottomTextLayer.translatesAutoresizingMaskIntoConstraints = false
        bottomTextLayer.topAnchor.constraint(equalTo: topTextLayer.bottomAnchor, constant: 0).isActive = true
        bottomTextLayer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
    }
    
    func createFirstTitleView(){
        self.firstTitle.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        self.firstTitle.font = UIFont(name: AppConstants.APP_AVENIR_BOLD, size: 20)
        self.firstTitle.text = "Подтверждение авторизации"
        
        view.addSubview(self.firstTitle)
        self.firstTitle.translatesAutoresizingMaskIntoConstraints = false
        self.firstTitle.topAnchor.constraint(equalTo:self.view.topAnchor, constant: self.bottomLayer.frame.minY + self.bottomLayer.bounds.height * 0.05).isActive = true
        self.firstTitle.leftAnchor.constraint(equalTo:
            self.view.leftAnchor , constant: self.bottomLayer.frame.width * 0.1).isActive = true
        
        self.secondTitle.textColor = UIColor(red: 0.567, green: 0.567, blue: 0.567, alpha: 1)
        self.secondTitle.font = UIFont(name: "Avenir-Black", size: 12)
        self.secondTitle.text = "Введите код из СМС"
        
        view.addSubview(self.secondTitle)
        self.secondTitle.translatesAutoresizingMaskIntoConstraints = false
        self.secondTitle.topAnchor.constraint(equalTo:firstTitle.bottomAnchor, constant: 0).isActive = true
        self.secondTitle.leftAnchor.constraint(equalTo:
            self.view.leftAnchor , constant: self.bottomLayer.frame.width * 0.1).isActive = true
    }
    
    func createLogInPanelView(){
        
        self.panel = AppAcceptCodePanel()
        self.view.addSubview(panel)
        
        panel.titleText = "Код из СМС:"
        panel.placeHolderText = "Код"
        panel.buttonText = "Подтвердить"
        
        panel.translatesAutoresizingMaskIntoConstraints = false
        panel.topAnchor.constraint(equalTo: self.secondTitle.bottomAnchor, constant: self.view.frame.height * 0.05).isActive = true
        panel.leftAnchor.constraint(equalTo:
        self.view.leftAnchor , constant: self.bottomLayer.frame.width * 0.1).isActive = true
        panel.rightAnchor.constraint(equalTo:
        self.view.rightAnchor , constant: -self.bottomLayer.frame.width * 0.1).isActive = true
        panel.heightAnchor.constraint(equalToConstant: 250).isActive = true
        panel.sendCodeButton.Action = self.checkCode
        panel.field.addTarget(self, action: #selector(changedPhoneField), for: .editingChanged)
        panel.field.delegate = self
        
        self.view.addSubview(self.backView)
        self.backView.translatesAutoresizingMaskIntoConstraints = false
        self.backView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.backView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.backView.centerXAnchor.constraint(equalToSystemSpacingAfter: self.view.centerXAnchor, multiplier: 0).isActive = true
        self.backView.topAnchor.constraint(equalTo: self.panel.bottomAnchor, constant: 0).isActive = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(backCommand))
        self.backView.isUserInteractionEnabled = true
        tap.numberOfTapsRequired = 1
        self.backView.addGestureRecognizer(tap)
    }
    
    @objc private func backCommand(){
        self.interactor?.back()
    }
    
    @objc private func changedPhoneField(textField: UITextField){
        let text = textField.text!
        self.interactor?.changeCodeField(code: text)
    }
    
    private func checkCode(button: UIButton) {
        self.interactor?.checkCode()
    }
    
    //MARK: -  AcceptViewerProtocol implementation
    
    var interactor: AcceptInteractorProtocol?
    var router: AcceptRouterProtocol?
    
    func showError(error: String) {
        DispatchQueue.main.async {
            self.panel.errorText = error
        }
    }
    
    func hideError() {
        DispatchQueue.main.async {
            self.panel.errorText = ""
        }
    }
    
    func changedBusyState(_ state: Bool) {
        DispatchQueue.main.async {
            self.panel.sendCodeButton.isBusy = state
        }
    }
    
    func showResentCodeButton() {
        
    }
    
    func hideResentCodeButton() {
        
    }
    
    func toggleBusyState(_ state: Bool) {
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
}
