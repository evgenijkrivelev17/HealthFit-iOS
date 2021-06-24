//
//  PeripheralViewModel.swift
//  HomeFit
//
//  Created by Евгений on 3/4/21.
//

import CoreBluetooth
import Foundation
import RxCocoa
import RxSwift

public struct PeripheralModel {
    private let id: UUID
    public var peripheralId: UUID {
        return id
    }

    private var device: CBPeripheral
    public var peripheralMode: CBPeripheral {
        return device
    }

    var data: [String: Any] = [:]
    public var peripheralData: [String: Any] {
        return data
    }

    private var rssi: NSNumber
    public var peripheralRssi: NSNumber {
        return rssi
    }

    init(id: UUID,
         device: CBPeripheral,
         data: [String: Any] = [:],
         rssi: NSNumber = 1)
    {
        self.id = id
        self.device = device
        self.data = data
        self.rssi = rssi
    }

    public mutating func upateValues(_ device: PeripheralModel) {
        self.device = device.peripheralMode
        data = device.peripheralData
        rssi = device.peripheralRssi
    }
}
