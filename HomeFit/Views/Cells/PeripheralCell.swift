import RxCocoa
import RxSwift
import UIKit

public class PeripheralCell: BaseTableViewCell<PeripheralModel> {
    public static var idCell = "PeripheralCell-ID"

    var panel: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 8
        return view
    }()

    var name: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir-Blod", size: 16)
        label.textColor = UIColor.black
        return label
    }()

    var descriptionName: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir-Blod", size: 16)
        label.textColor = UIColor.black
        return label
    }()

    var powerSignal: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir-Blod", size: 16)
        label.textColor = UIColor.black
        return label
    }()

    var state: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir-Blod", size: 10)
        label.textColor = UIColor.black
        label.isHidden = true
        return label
    }()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var titleNameObserver: Disposable = {
        var disposable = Disposables.create()
        return disposable
    }()

    var signalObserver: Disposable = {
        var disposable = Disposables.create()
        return disposable
    }()

    var connectedObserver: Disposable = {
        var disposable = Disposables.create()
        return disposable
    }()

    func setUpUI() {
        setUpPanel()
        setUpTitle()
        setUpSignal()
        setUpState()
    }

    func setUpPanel() {
        addSubview(panel)
        panel.translatesAutoresizingMaskIntoConstraints = false
        panel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        panel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        panel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        panel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }

    func setUpTitle() {
        panel.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: panel.topAnchor, constant: 15).isActive = true
        name.leftAnchor.constraint(equalTo: panel.leftAnchor, constant: 10).isActive = true
        name.rightAnchor.constraint(equalTo: panel.rightAnchor, constant: -10).isActive = true
    }

    func setUpSignal() {
        panel.addSubview(powerSignal)
        powerSignal.translatesAutoresizingMaskIntoConstraints = false
        powerSignal.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15).isActive = true
        powerSignal.leftAnchor.constraint(equalTo: panel.leftAnchor, constant: 10).isActive = true
        powerSignal.widthAnchor.constraint(equalTo: panel.widthAnchor, multiplier: 0.6).isActive = true
        powerSignal.bottomAnchor.constraint(equalTo: panel.bottomAnchor, constant: -15).isActive = true
    }

    func setUpState() {
        panel.addSubview(state)
        state.translatesAutoresizingMaskIntoConstraints = false
        state.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15).isActive = true
        state.leftAnchor.constraint(equalTo: powerSignal.rightAnchor, constant: 10).isActive = true
        state.rightAnchor.constraint(equalTo: panel.rightAnchor, constant: -10).isActive = true
    }

    override func updateValues() {
        guard let data = data else { return }
        name.text = "Name: " + (data.peripheralMode.name ?? "Unknown")
        powerSignal.text = "Signal: " + data.peripheralRssi.stringValue
        state.text = data.peripheralMode.state == .connected ? "Connected" : ""
    }
}
