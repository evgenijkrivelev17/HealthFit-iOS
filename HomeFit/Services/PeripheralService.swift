import CoreBluetooth
import Foundation
import RxSwift

class PeriperalService: NSObject, PeripheralServiceDelegate {
    public typealias RemoteDevice = PeripheralModel

    public typealias StateManager = CBManagerState

    public static var shared = PeriperalService()

    public private(set) var devices: [RemoteDevice]

    public private(set) var stateService: BehaviorSubject<CBManagerState>

    public private(set) var connectedDevices: BehaviorSubject<[PeripheralModel]>

    public private(set) var foundedDevices: BehaviorSubject<[PeripheralModel]>

    public private(set) var scanning: BehaviorSubject<Bool>

    private var manager: CBCentralManager?

    private var currentConnectedPeripheral: CBPeripheral?

    init(peripherals: [RemoteDevice] = [],
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

    override func observeValue(forKeyPath keyPath: String?, of _: Any?, change _: [NSKeyValueChangeKey: Any]?, context _: UnsafeMutableRawPointer?) {
        guard let key = keyPath else {
            return
        }
        switch key {
            case "isScanning":
                changedScanningState()
            default: break
        }
    }

    public func connect(to device: PeripheralModel, with options: [String: Any] = [:]) {
        guard let manager = manager else {
            return
        }
        currentConnectedPeripheral = device.device
        stopScan()
        manager.connect(device.device, options: options)
    }

    public func disconnect(to device: PeripheralModel) {
        guard let manager = manager else {
            return
        }
        manager.cancelPeripheralConnection(device.device)
    }

    public func startScan() {
        guard let manager = manager else {
            manager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
            addCustomPropertyObserver(to: manager!, observer: self, properties: ["isScanning": [.new]])
            return
        }
        manager.scanForPeripherals(withServices: nil, options: nil)
    }

    public func stopScan() {
        guard let manager = manager else {
            return
        }
        manager.stopScan()
    }

    private func addDevice(_ device: RemoteDevice) {
        devices.append(device)
        foundedDevices.onNext(devices)
    }

    private func updateData(to device: inout RemoteDevice, with data: RemoteDevice) {
        device.upateValues(data)
    }

    private func connected(with _: RemoteDevice) {
        let allConnectedDevices = devices.filter { $0.device.state == .connected }
        connectedDevices.onNext(allConnectedDevices)
    }

    private func changedScanningState() {
        guard let service = manager else {
            return
        }
        let state = service.isScanning
        scanning.onNext(state)
    }

    private func addCustomPropertyObserver(to manager: CBCentralManager, observer: NSObject, properties: [String: NSKeyValueObservingOptions]) {
        for prop in properties {
            manager.addObserver(observer, forKeyPath: prop.key, options: prop.value, context: nil)
        }
    }

    private func removeCustomPropertyObserver(to manager: CBCentralManager, observer: NSObject, properties: [String]) {
        for prop in properties {
            manager.removeObserver(observer, forKeyPath: prop)
        }
    }

    private func failedConnection(to device: CBPeripheral, error: Error?) {
        print("Problem in connection with \(device). Error: \(error)")
    }

    deinit {
        guard let manager = manager else {
            return
        }
        removeCustomPropertyObserver(to: manager, observer: self, properties: ["isScanning"])
        print("Deinitialize PeripheralsService class")
    }
}

// MARK: - CBCentralManagerDelegate initialization

extension PeriperalService: CBCentralManagerDelegate {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        guard let manager = manager, manager == central else {
            return
        }
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
        updateData(to: &oldDevice, with: device)
    }

    public func centralManager(service: CBCentralManager, didConnect peripheral: CBPeripheral) {
        guard manager == service else {
            return
        }

        let connectedDevice = RemoteDevice(device: peripheral)
        if let index = devices.firstIndex(where: { $0.id.uuidString == peripheral.identifier.uuidString }), index == -1 {
            addDevice(connectedDevice)
        }
        connected(with: connectedDevice)
    }

    public func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        guard manager == central else {
            return
        }
        failedConnection(to: peripheral, error: error)
    }
}

// MARK: - CBPeripheralManagerDelegate protocol initialize

extension PeriperalService: CBPeripheralManagerDelegate {
    public func peripheralManagerDidUpdateState(_ manager: CBPeripheralManager) {
        guard let service = self.manager else {
            return
        }
        guard service == manager else {
            return
        }
        stateService.onNext(manager.state)
    }
}
