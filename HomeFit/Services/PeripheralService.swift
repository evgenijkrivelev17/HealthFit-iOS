import CoreBluetooth
import Foundation
import RxSwift

public class PeriperalService: NSObject {
//    public static var shared: PeriperalService = PeriperalService()

    // MARK: - Default values

    private var devices: [RemoteDevice]

    private var manager: CBCentralManager!

    private var disposeBag: DisposeBag

    public var foundDevices: BehaviorSubject<[RemoteDevice]>

    private var stateManager: BehaviorSubject<StateManager>

    private var isScanning: BehaviorSubject<Bool>

    private init(devices: [RemoteDevice] = [],
                 foundObserver: BehaviorSubject<[RemoteDevice]>,
                 stateObserver: BehaviorSubject<StateManager>,
                 isScanningObserver: BehaviorSubject<Bool>)
    {
        self.devices = devices
        foundDevices = foundObserver
        stateManager = stateObserver
        isScanning = isScanningObserver
        disposeBag = DisposeBag()
    }
}

// MARK: - CBCentralManagerDelegate initialization

// extension PeriperalService: CBCentralManagerDelegate {
////    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
////        if central == manager {}
////    }
////
////    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
////        guard central == manager else {
////            return
////        }
////
////        _ = RemoteDevice(id: peripheral.identifier, device: peripheral, data: advertisementData, rssi: RSSI)
////
//////        guard var oldDevice = devices.first(where: { $0.peripheralId.uuidString == device.peripheralId.uuidString }) else { devices.append(device)
//////            foundDevices.onNext(device)
//////            return
//////        }
//////
//////        oldDevice.upateValues(device)
////    }
////
////    public func centralManager(_: CBCentralManager, didConnect peripheral: CBPeripheral) {
////        let index = devices.firstIndex { $0.peripheralId.uuidString == peripheral.identifier.uuidString } ?? -1
////        guard index != -1 else { return }
////    }
// }

// MARK: - CBPeripheralManagerDelegate protocol initialize

extension PeriperalService: CBPeripheralManagerDelegate {
    public func peripheralManagerDidUpdateState(_: CBPeripheralManager) {}
}

// MARK: - PeripheralServiceDelegate protocol initialize

extension PeriperalService: PeripheralServiceDelegate {
    public typealias RemoteDevice = PeripheralModel

    public typealias StateManager = CBManagerState

    public var stateService: BehaviorSubject<CBManagerState> {
        return stateManager
    }

    public func connect(device: PeripheralModel, options: [String: Any] = [:]) {
        manager.connect(device.peripheralMode, options: options)
    }

    public func disconnect(device: PeripheralModel) {
        manager.cancelPeripheralConnection(device.peripheralMode)
    }

    public func startScan() {
        manager.scanForPeripherals(withServices: nil, options: nil)
    }

    public func stopScan() {
        manager.stopScan()
    }
}
