//
//  PeripheralViewModel.swift
//  HomeFit
//
//  Created by Евгений on 3/4/21.
//

import Foundation
import RxSwift
import RxCocoa
import CoreBluetooth


public struct PeripheralModel {
    
    private let _id: UUID
    public var ID: UUID {
        return self._id
    }
    
    public var _device: CBPeripheral
    public var Device: CBPeripheral {
        return self._device
    }
    
    public var _data: [String : Any] = [:]
    public var Data: [String : Any] {
        return self._data
    }
    
    public var _rssi: NSNumber?
    public var RSSI: NSNumber? {
        return self._rssi
    }
    
    
    init(Id: UUID, device: CBPeripheral, data: [String : Any] = [:], rssi: NSNumber? = nil) {
        self._id = Id
        self._device = device
        self._data = data
        self._rssi = rssi
    }
    
    public mutating func upateValues(_ device: PeripheralModel) {
        self._device = device.Device
        self._data = device.Data
        self._rssi = device.RSSI
    }
}
