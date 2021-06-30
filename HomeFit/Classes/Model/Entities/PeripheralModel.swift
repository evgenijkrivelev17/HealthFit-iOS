import CoreBluetooth
import Foundation
import RxCocoa
import RxSwift

public struct PeripheralModel {
    public var id: UUID {
        return device.identifier
    }

    public private(set) var device: CBPeripheral

    public private(set) var peripheralData: [String: Any]

    public private(set) var peripheralRssi: NSNumber

    init(device: CBPeripheral,
         data: [String: Any] = [:],
         rssi: NSNumber = 1)
    {
        self.device = device
        peripheralData = data
        peripheralRssi = rssi
    }

    public mutating func upateValues(_ device: PeripheralModel) {
        self.device = device.device
        peripheralData = device.peripheralData
        peripheralRssi = device.peripheralRssi
    }
}

// MARK: - implementation Equatable

extension PeripheralModel: Equatable {
    public static func == (lhs: PeripheralModel, rhs: PeripheralModel) -> Bool {
        return lhs.id.uuidString == rhs.id.uuidString
    }
}
