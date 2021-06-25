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

    var foundDevices: BehaviorSubject<[RemoteDevice]> { get }

    var stateService: BehaviorSubject<StateManager> { get }

    func connect(device: RemoteDevice, options: [String: Any])
    func disconnect(device: RemoteDevice)

    func startScan()
    func stopScan()
}
