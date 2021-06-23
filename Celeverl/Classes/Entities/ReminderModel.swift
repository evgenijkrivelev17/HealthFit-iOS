//
//  SettingsModel.swift
//  HappyChild (mobile)
//
//  Created by Евгений on 1/9/20.
//  Copyright © 2020 oberon. All rights reserved.
//

import Foundation

public class ReminderModel: BaseModel, Codable {
    
    @objc public var WarningNotificationMinutes:Int = 0
    @objc public var WarningEventsFrequencyForInterval: Int = 0
    @objc public var HappinessNotificationMinutes: Int = 0
    @objc public var HappinessEventsFrequencyForInterval:Int = 0
    @objc public var NormalSituationNotificationMinutes: Int = 0
    @objc public var NormalEventsFrequencyForInterval: Int = 0
    @objc public var InterpretUnknownAsNormal: Bool = false
    @objc public var SendOnlinePushNotifications: Bool = false
    
    override init(){
        super.init()
    }
       
    convenience init(_ dic: [String: Any]) {
        self.init()
        self.WarningNotificationMinutes = dic["WarningNotificationMinutes"] as? Int ?? 0
        self.WarningEventsFrequencyForInterval = dic["WarningEventsFrequencyForInterval"] as? Int ?? 0
        self.HappinessNotificationMinutes = dic["HappinessNotificationMinutes"] as? Int ?? 0
        self.HappinessEventsFrequencyForInterval = dic["HappinessEventsFrequencyForInterval"] as? Int ?? 0
        self.NormalSituationNotificationMinutes = dic["NormalSituationNotificationMinutes"] as? Int ?? 0
        self.NormalEventsFrequencyForInterval = dic["NormalEventsFrequencyForInterval"] as? Int ?? 0
        self.InterpretUnknownAsNormal = dic["InterpretUnknownAsNormal"] as? Bool ?? false
        self.SendOnlinePushNotifications = dic["SendOnlinePushNotifications"] as? Bool ?? false
    }
    
    public func getPropertiesList() -> [(index:Int,propertyName:String,value:Any)]{
        
        var list:[(Int,String,Any)] = []
        
        let mirrored_object = Mirror(reflecting: self)

        for (index, attr) in mirrored_object.children.enumerated() {
            if let propertyName = attr.label {
                list.append((index,propertyName, attr.value))
          }
        }
        return list
    }
}


public class NetworkSettingModel: Codable {
    
    @objc public var userId: String = ""
    @objc public var settings: ReminderModel = ReminderModel()
    
}
