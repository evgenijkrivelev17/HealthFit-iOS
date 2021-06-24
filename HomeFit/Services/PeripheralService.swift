//
//  PeripheralService.swift
//  HomeFit
//
//  Created by Евгений on 3/4/21.
//
 
import Foundation
import CoreBluetooth
import RxSwift


public class PeriperalService: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    
    
    public static var shared: PeriperalService = PeriperalService()
    //MARK: - Default values
    
    private var _devices: [RemoteDevice] = []
    private var manager: CBCentralManager
    
    private var disposeBag: DisposeBag = DisposeBag()
    
    private var _foundDevices: PublishSubject<RemoteDevice> = PublishSubject<RemoteDevice>.init()
    private var _stateService: PublishSubject<StateManager> = PublishSubject<StateManager>.init()
    private var _isScanning: PublishSubject<Bool> = PublishSubject<Bool>.init()
    
    
    
   
    
    private init() {
        self.manager = CBCentralManager(delegate: self, queue: nil)
        super.init()
    }
    
    
    
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central == self.manager {
        }
    }
    
    
    
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        guard central == self.manager else { return }
            
        let device = RemoteDevice(Id:peripheral.identifier ,device: peripheral, data: advertisementData, rssi: RSSI)
        
        guard var oldDevice = self.devices.first(where: { $0.ID.uuidString == device.ID.uuidString }) else {            self._devices.append(device)
            self.foundDevices.onNext(device)
            return
        }
        
        oldDevice.upateValues(device)
        
    }
    
    
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        let index = self.devices.firstIndex { $0.ID.uuidString == peripheral.identifier.uuidString } ?? -1
        guard index != -1 else { return }
        
        
    }
    
    
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("Connected device")
    }
    
    
}



//MARK: - PeripheralServiceDelegate protocol initialize

extension PeriperalService: PeripheralServiceDelegate {
    
    
    
    public typealias RemoteDevice = PeripheralModel
    
    public typealias StateManager = CBManagerState
    
    public var devices: [RemoteDevice]  {
        get {
            return self._devices
        }
    }
    
    public var foundDevices: PublishSubject<RemoteDevice> {
        return self._foundDevices
    }
    
    public var stateService: PublishSubject<StateManager> {
        return self._stateService
    }
    
    public var isScanning: PublishSubject<Bool> {
        return self._isScanning
    }
    
    public func startScan(){
        self.manager.scanForPeripherals(withServices: nil, options: nil)
        self._isScanning.onNext(self.manager.isScanning)
    }
    
    public func stopScan(){
        self.manager.stopScan()
        self._isScanning.onNext(self.manager.isScanning)
    }
    
    public func connectToDevice(_ device: RemoteDevice) {
        self.manager.connect(device.Device, options: nil)
    }
}


