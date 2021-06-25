import CoreBluetooth
import Foundation
import RxCocoa
import RxSwift

public struct PeripheralModel {
    public var id: UUID {
        return device.identifier
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

    init(device: CBPeripheral,
         data: [String: Any] = [:],
         rssi: NSNumber = 1)
    {
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
