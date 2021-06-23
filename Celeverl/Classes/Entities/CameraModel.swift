//
//  Camera.swift
//  HappyChild
//
//  Created by Евгений on 11/14/19.
//  Copyright © 2019 Oberon. All rights reserved.
//

import Foundation

public class CameraModel: BaseModel, Codable {
    
    public var Id: String = ""
    public var CameraName: String = ""
    public var DateEnd: Date? = nil
    public var DateEndStr: String = ""
    public var DateStart: Date? = nil
    public var DateStartStr: String = ""
    public var StartHour: Int = 0
    public var EndHour: Int = 0
    public var IsActive:Bool = false
    public var IsForWholeDay: Bool = false
    public var NextRefreshingDateUts: Date? = nil
    public var SelectedDays: [Any] = []
    public var TypeCamera: Int = 0
    public var Url: String = ""
    public var Description: String = ""
    
    init(id: String, name: String, url:String, description:String, isOffline: Bool){
        super.init()
        self.Id = id
        self.CameraName = name
        self.Url = url
        self.Description = description
        self.IsActive = isOffline
    }
    
    init(dic: [String:Any]){
        
        self.Id = dic["Id"] as? String ?? ""
        self.CameraName = dic["CameraName"] as? String ?? ""
        self.DateEnd = dic["DateEnd"] as? Date ?? nil
        self.DateEndStr = dic["DateEndStr"] as! String
        
        self.DateStart = dic["DateStart"] as? Date ?? nil
        self.DateStartStr = dic["DateStartStr"] as! String
        self.StartHour = dic["StartHour"] as! Int
        self.EndHour = dic["EndHour"] as! Int
        self.IsActive = dic["IsActive"] as? Bool ?? false
        self.IsForWholeDay = dic["IsForWholeDay"] as? Bool ?? false
        self.NextRefreshingDateUts = dic["NextRefreshingDateUts"] as? Date ?? nil
        //self.SelectedDays = dic["SelectedDays"] as? [Any] ?? []
        self.TypeCamera = dic["Type"] as? Int ?? 0
        self.Url = dic["Url"] as? String ?? ""
    }
    
    private enum CodingKeys: String, CodingKey {
        case Id
        case CameraName
        case DateEnd
        case DateEndStr
        case DateStart
        case DateStartStr
        case StartHour
        case EndHour
        case IsActive
        case IsForWholeDay
        case NextRefreshingDateUts
        case TypeCamera = "Type"
        case Url
    }
    
    required public init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Id = try values.decode(String.self, forKey: .Id)
        CameraName = try values.decode(String.self, forKey: .CameraName)
        DateEnd = try values.decode(Date.self, forKey: .DateEnd)
        DateEndStr = try values.decode(String.self, forKey: .DateEndStr)
        DateStart = try values.decode(Date.self, forKey: .DateStart)
        DateStartStr = try values.decode(String.self, forKey: .DateStartStr)
        StartHour = try values.decode(Int.self, forKey: .StartHour)
        EndHour = try values.decode(Int.self, forKey: .EndHour)
        IsActive = try values.decode(Bool.self, forKey: .IsActive)
        IsForWholeDay = try values.decode(Bool.self, forKey: .IsForWholeDay)
        NextRefreshingDateUts = try values.decode(Date.self, forKey: .NextRefreshingDateUts)
        //SelectedDays = try values.decode([AnyObject].self, forKey: .SelectDays)
        TypeCamera = try values.decode(Int.self, forKey: .TypeCamera)
        Url = try values.decode(String.self, forKey: .Url)
    }

}
