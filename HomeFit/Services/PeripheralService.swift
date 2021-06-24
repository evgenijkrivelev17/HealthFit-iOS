//
//  PeripheralService.swift
//  HomeFit
//
//  Created by Евгений on 3/4/21.
//

import CoreBluetooth
import Foundation
import RxSwift

public class PeriperalService: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
//    public static var shared: PeriperalService = PeriperalService()

    // MARK: - Default values

    private var devices: [RemoteDevice] = []
    private var manager: CBCentralManager

    private var disposeBag = DisposeBag()

    private var foundDevices = BehaviorSubject<[RemoteDevice]>.init(value: [])

    private var stateService = BehaviorSubject<StateManager>.init(value: .poweredOff)

    private var isScanning = BehaviorSubject<Bool>.init(value: false)

//    private init() {
//        self.manager = CBCentralManager(delegate: self, queue: nil)
//    }
//
//    required override init(){
//
//    }
//

    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central == manager {}
    }

    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        guard central == manager else {
            return
        }

        let device = RemoteDevice(id: peripheral.identifier, device: peripheral, data: advertisementData, rssi: RSSI)

        guard var oldDevice = devices.first(where: { $0.peripheralId.uuidString == device.peripheralId.uuidString }) else { devices.append(device)
            foundDevices.onNext(device)
            return
        }

        oldDevice.upateValues(device)
    }

    public func centralManager(_: CBCentralManager, didConnect peripheral: CBPeripheral) {
        let index = devices.firstIndex { $0.peripheralId.uuidString == peripheral.identifier.uuidString } ?? -1
        guard index != -1 else { return }
    }

    public func peripheral(_: CBPeripheral, didDiscoverServices _: Error?) {
        print("Connected device")
    }
}

// MARK: - PeripheralServiceDelegate protocol initialize

extension PeriperalService: PeripheralServiceDelegate {
    public typealias RemoteDevice = PeripheralModel

    public typealias StateManager = CBManagerState

    public var foundDevices: PublishSubject<[PeripheralModel]> {}

    public func connect(to _: PeripheralModel) {}

    public func disconnect(to _: PeripheralModel) {}

    public func start() {}
}
