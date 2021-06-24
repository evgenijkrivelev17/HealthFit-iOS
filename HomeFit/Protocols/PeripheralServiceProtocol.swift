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

    var foundDevices: PublishSubject<[RemoteDevice]> { get }

    var stateService: PublishSubject<StateManager> { get }

    func connect(to device: RemoteDevice)
    func disconnect(to device: RemoteDevice)

    func start()
    func stopScan()
}
