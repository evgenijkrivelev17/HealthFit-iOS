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
    
    private let id: UUID
    public var peripheralId: UUID {
        return id
    }
    
    private var device: CBPeripheral
    public var peripheralMode: CBPeripheral {
        return device
    }
    
    var data: [String : Any] = [:]
    public var peripheralData: [String : Any] {
        return data
    }
    
    private var rssi: NSNumber
    public var peripheralRssi: NSNumber {
        return rssi
    }
    
    init(id: UUID,
         device: CBPeripheral,
         data: [String : Any] = [:],
         rssi: NSNumber = -1000) {
        self.id = id
        self.device = device
        self.data = data
        self.rssi = rssi
    }
    public mutating func upateValues(_ device: PeripheralModel) {
        self.device = device.peripheralMode
        self.data = device.peripheralData
        self.rssi = device.peripheralRssi
    }
}
