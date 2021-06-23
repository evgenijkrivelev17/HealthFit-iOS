//
//  CameraViewCell.swift
//  HappyChild
//
//  Created by Евгений on 11/14/19.
//  Copyright © 2019 Oberon. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

public class NotificationViewCell: BaseUITableViewCell {
    
    static let resueseId: String = "NotificationViewCell"
    
    private var titleView: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 18)
        label.textColor = .black
        return label
    }()
    
    private var descriptionView: UILabel = {
       var label = UILabel()
       label.numberOfLines = 0
       label.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 14)
       label.textColor = .darkGray
       return label
    }()
    
    public var backView: UIView = {
        var back = UIView()
        back.layer.cornerRadius = 10
        back.layer.masksToBounds = true
        return back
    }()
    
    public var dataView: UILabel = {
        var dataLabel = UILabel()
        dataLabel.font = UIFont(name: AppConstants.APP_ROBOTO_MEDIUM, size: 14)
        dataLabel.textColor = .black
        return dataLabel
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: MenuTableViewCell.self.resueseId)
        self.configuareViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func OnPropertyChanged(_ propertyName: String) {
        if propertyName == "BindingContext" {
            self.updateView()
        }
    }
    
    private func updateView(){
        guard let model = self.BindingContext as? NotificationModel else { return }
        self.titleView.text = model.title
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        self.descriptionView.text = model.description
        if let date = formatter.date(from: model.usersDateStr!) {
            let shortTime = DateFormatter()
            shortTime.dateFormat = "HH:mm"
            self.dataView.text = shortTime.string(from: date)
        }
       // self.titleView.text = model.title.hexaDecoededString(characters: model.title)
      //  self.descriptionView.text = model.description.hexaDecoededString(characters: model.description)
    }
    func data(fromHexaStr hexaStr: String) -> Data? {
        var data = Data(capacity: hexaStr.count / 2)
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: hexaStr, range: NSMakeRange(0, hexaStr.utf16.count)) { match, flags, stop in
            let byteString = (hexaStr as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }

        guard data.count > 0 else { return nil }

        return data
    }
    
    private func configuareViews(){
        self.confgiaureBackView()
        self.configuareTitleView()
        self.configuareDescriptionView()
        self.configuareDataView()
    }
    
    private func configuareTitleView(){
        self.addSubview(self.titleView)
        self.titleView.translatesAutoresizingMaskIntoConstraints = false
        self.titleView.leftAnchor.constraint(equalTo: self.backView.leftAnchor, constant: 10).isActive = true
        self.titleView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 10).isActive = true
    }
    
    private func configuareDescriptionView(){
        self.addSubview(self.descriptionView)
        self.descriptionView.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionView.rightAnchor.constraint(equalTo: self.backView.rightAnchor, constant: -20).isActive = true
        self.descriptionView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 20).isActive = true
        self.descriptionView.leftAnchor.constraint(equalTo: self.backView.leftAnchor, constant: 10).isActive = true
    }
    
    private func confgiaureBackView(){
        self.addSubview(self.backView)
        self.backView.translatesAutoresizingMaskIntoConstraints = false
        self.backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        self.backView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.backView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.backView.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    }
    
    private func configuareDataView(){
        self.addSubview(self.dataView)
        self.dataView.translatesAutoresizingMaskIntoConstraints = false
        self.dataView.topAnchor.constraint(equalTo: self.descriptionView.bottomAnchor, constant: 15).isActive = true
        self.dataView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -10).isActive = true
        self.dataView.rightAnchor.constraint(equalTo: self.backView.rightAnchor, constant: -10).isActive = true
        self.dataView.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    }
}
extension String {

    func hexaDecoededString(characters : String) -> String {

        var newData = Data()
        var emojiStr: String = ""
        for char in characters {

            let str = String(char)
            if str == "\\" || str.lowercased() == "x" {
                emojiStr.append(str)
            }
            else if emojiStr.hasPrefix("\\x") || emojiStr.hasPrefix("\\X") {
                emojiStr.append(str)
                if emojiStr.count == 4 {
                    /// It can be a hexa value
                    let value = emojiStr.replacingOccurrences(of: "\\x", with: "")
                    if let byte = UInt8(value, radix: 16) {
                        newData.append(byte)
                    }
                    else {
                        newData.append(emojiStr.data(using: .utf8)!)
                    }
                    /// Reset emojiStr
                    emojiStr = ""
                }
            }
            else {
                /// Append the data as it is
                newData.append(str.data(using: .utf8)!)
            }
        }

        let decodedString = String(data: newData, encoding: String.Encoding.utf8)
        return decodedString ?? ""
    }
}
