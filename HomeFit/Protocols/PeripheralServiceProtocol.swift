//
//  PeripheralServiceProtocol.swift
//  HomeFit
//
//  Created by Yauheni Kryvialiou on 24.06.21.
//
import RxSwift

public protocol PeripheralServiceDelegate: AnyObject {
    
    associatedtype RemoteDevice
    
    associatedtype StateManager
    
    var devices: [RemoteDevice] { get }
    
    var foundDevices: PublishSubject<RemoteDevice> { get }
    
    var stateService: PublishSubject<StateManager> { get }
    
    func connectToDevice(_ device: RemoteDevice)
    
    func startScan()
    
    func stopScan()
}
