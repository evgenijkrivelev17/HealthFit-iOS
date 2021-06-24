//
//  PeripheralCell.swift
//  HomeFit
//
//  Created by Евгений on 3/8/21.
//

import UIKit
import RxCocoa
import RxSwift


public class PeripheralCell: BaseTableViewCell<PeripheralModel> {
    
    public static var IdCell = "PeripheralCell-ID"
    
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
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
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
        self.setUpPanel()
        self.setUpTitle()
        self.setUpSignal()
        self.setUpState()
    }
    func setUpPanel() {
        self.addSubview(self.panel)
        self.panel.translatesAutoresizingMaskIntoConstraints = false
        self.panel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.panel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.panel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.panel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    func setUpTitle() {
        self.panel.addSubview(self.name)
        self.name.translatesAutoresizingMaskIntoConstraints = false
        self.name.topAnchor.constraint(equalTo: self.panel.topAnchor, constant: 15).isActive = true
        self.name.leftAnchor.constraint(equalTo: self.panel.leftAnchor, constant: 10).isActive = true
        self.name.rightAnchor.constraint(equalTo: self.panel.rightAnchor, constant: -10).isActive = true
    }
    func setUpSignal() {
        self.panel.addSubview(self.powerSignal)
        self.powerSignal.translatesAutoresizingMaskIntoConstraints = false
        self.powerSignal.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 15).isActive = true
        self.powerSignal.leftAnchor.constraint(equalTo: self.panel.leftAnchor, constant: 10).isActive = true
        self.powerSignal.widthAnchor.constraint(equalTo: self.panel.widthAnchor, multiplier: 0.6).isActive = true
        self.powerSignal.bottomAnchor.constraint(equalTo: self.panel.bottomAnchor, constant: -15).isActive = true
    }
    func setUpState() {
        self.panel.addSubview(self.state)
        self.state.translatesAutoresizingMaskIntoConstraints = false
        self.state.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 15).isActive = true
        self.state.leftAnchor.constraint(equalTo: self.powerSignal.rightAnchor, constant: 10).isActive = true
        self.state.rightAnchor.constraint(equalTo: self.panel.rightAnchor, constant: -10).isActive = true
    }
    override func setData(to data: PeripheralModel) {
        self.Data = data
        self.updateValues()
    }
    override func updateValues() {
        guard let data = self.Data else { return }
        self.name.text = "Name: " + (data.Device.name ?? "Unknown")
        self.powerSignal.text = "Signal: " + data.RSSI!.stringValue
        self.state.text = data.Device.state == .connected ? "Connected" : ""
    }
}
