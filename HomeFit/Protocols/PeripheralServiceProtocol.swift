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

    var foundedDevices: BehaviorSubject<[RemoteDevice]> { get }

    var connectedDevices: BehaviorSubject<[RemoteDevice]> { get }

    var stateService: BehaviorSubject<StateManager> { get }

    var scanning: BehaviorSubject<Bool> { get }

    func connect(to device: RemoteDevice, with options: [String: Any])
    func disconnect(to device: RemoteDevice)

    func startScan()
    func stopScan()
}
