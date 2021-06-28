import CoreBluetooth
import Foundation
import RxSwift

class PeriperalService: NSObject, PeripheralServiceDelegate {
    public static var shared = PeriperalService()

    private var manager: CBCentralManager!

    public typealias RemoteDevice = PeripheralModel

    public typealias StateManager = CBManagerState

    public private(set) var devices: [RemoteDevice]

    public private(set) var stateService: BehaviorSubject<CBManagerState>

    public private(set) var connectedDevices: BehaviorSubject<[PeripheralModel]>

    public private(set) var foundedDevices: BehaviorSubject<[PeripheralModel]>

    public private(set) var scanning: BehaviorSubject<Bool>

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

    private init(peripherals: [RemoteDevice] = [],
                 foundObserver: BehaviorSubject<[RemoteDevice]> = .init(value: []),
                 connectedObserver: BehaviorSubject<[RemoteDevice]> = .init(value: []),
                 stateObserver: BehaviorSubject<StateManager> = .init(value: .poweredOff),
                 isScanningObserver: BehaviorSubject<Bool> = .init(value: false))
    {
        devices = peripherals
        foundedDevices = foundObserver
        connectedDevices = connectedObserver
        stateService = stateObserver
        scanning = isScanningObserver
        super.init()
    }

    override convenience init() {
        self.init()
        manager = CBCentralManager(delegate: self, queue: nil)
    }

    private func addDevice(_ device: RemoteDevice) {
        devices.append(device)
        foundedDevices.onNext(devices)
    }

    private func updateDevice(to device: inout RemoteDevice, data: RemoteDevice) {
        device.upateValues(data)
    }

    private func informConnectDevice(_: RemoteDevice) {
        let allConnectedDevices = devices.filter { $0.peripheralMode.state == .connected }
        connectedDevices.onNext(allConnectedDevices)
    }
}

// MARK: - CBCentralManagerDelegate initialization

extension PeriperalService: CBCentralManagerDelegate {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        guard manager == central else { return }
        stateService.onNext(manager.state)
    }

    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        guard central == manager else {
            return
        }

        let device = RemoteDevice(device: peripheral, data: advertisementData, rssi: RSSI)

        guard var oldDevice = devices.first(where: { $0.id.uuidString == device.id.uuidString }) else {
            addDevice(device)
            return
        }
        updateDevice(to: &oldDevice, data: device)
    }

    public func centralManager(service: CBCentralManager, didConnect peripheral: CBPeripheral) {
        guard manager == service else { return }

        let connectedDevice = RemoteDevice(device: peripheral)
        guard let index = devices.firstIndex(where: { $0.id.uuidString == peripheral.identifier.uuidString }), index != -1 else {
            addDevice(connectedDevice)
            informConnectDevice(connectedDevice)
            return
        }
        informConnectDevice(connectedDevice)
    }
}

// MARK: - CBPeripheralManagerDelegate protocol initialize

extension PeriperalService: CBPeripheralManagerDelegate {
    public func peripheralManagerDidUpdateState(_: CBPeripheralManager) {}
}
