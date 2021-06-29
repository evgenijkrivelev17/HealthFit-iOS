import CoreBluetooth
import Foundation
import RxCocoa
import RxSwift

public class SearchDevicesViewModel: BaseViewModelProtocol {
    struct Input {
        var searchDeviceTextField: Observable<String>
        var startScan: Observable<Void>
        var stopScan: Observable<Void>
        var goToDevice: Observable<Device>
        var connectDevice: Observable<IndexPath>
        var disconnectDevice: Observable<IndexPath>
    }

    struct Output {
        var devices: Observable<[Device]>
        var isBusy: Observable<Bool>
        var isScanning: Observable<Bool>
        var enableScanning: Observable<CBManagerState>
    }

    typealias Device = PeripheralModel

    typealias InputViewType = Input

    typealias OutputViewType = Output

    var input: Input

    var devices: BehaviorSubject<[Device]>

    var isBusy: Observable<Bool>

    var enableScanning: BehaviorSubject<CBManagerState>

    var dispose: DisposeBag

    private var peripheralService: PeriperalService

    init(inputModel: Input,
         devicesObservable: BehaviorSubject<[Device]>,
         busyObservable: BehaviorSubject<Bool>,
         enableScanningObservable: BehaviorSubject<CBManagerState>,
         deviceService: PeriperalService)
    {
        peripheralService = deviceService
        devices = devicesObservable
        isBusy = busyObservable
        enableScanning = enableScanningObservable
        input = inputModel
        dispose = DisposeBag()
    }

    convenience init(input: Input,
                     peripheralService: PeriperalService = PeriperalService.shared,
                     devices: BehaviorSubject<[Device]> = .init(value: []),
                     isBusy: BehaviorSubject<Bool> = .init(value: false),
                     enable: BehaviorSubject<CBManagerState> = .init(value: .poweredOff))
    {
        self.init(inputModel: input,
                  devicesObservable: devices,
                  busyObservable: isBusy,
                  enableScanningObservable: enable,
                  deviceService: peripheralService)
    }

    func configure(input: Input) -> Output {
        input.connectDevice.subscribe { [weak self] event in
            guard let self = self, let indexPath = event.element else {
                return
            }
            guard let devices = try? self.devices.value() else {
                return
            }
            self.connectDevice(device: devices[indexPath.row])
        }.disposed(by: dispose)

        input.disconnectDevice.subscribe { [weak self] event in
            guard let self = self, let indexPath = event.element else {
                return
            }
            guard let devices = try? self.devices.value() else {
                return
            }
            self.disconnectDevice(device: devices[indexPath.row])
        }.disposed(by: dispose)

        input.startScan.subscribe { [weak self] _ in
            guard let self = self else {
                return
            }
            self.peripheralService.startScan()
        }.disposed(by: dispose)

        input.stopScan.subscribe { [weak self] _ in
            guard let self = self else {
                return
            }
            self.peripheralService.stopScan()
        }.disposed(by: dispose)

        peripheralService.foundedDevices.distinctUntilChanged().subscribe { [weak self] event in
            guard let self = self, let devices = event.element else {
                return
            }
            self.devices.onNext(devices)
        }.disposed(by: dispose)

        peripheralService.stateService.subscribe { [weak self] event in
            guard let self = self, let state = event.element else {
                return
            }
            self.enableScanning.onNext(state)
        }.disposed(by: dispose)

        peripheralService.foundedDevices.subscribe { [weak self] event in
            guard let self = self, let newDevices = event.element else {
                return
            }
            self.devices.onNext(newDevices)
        }.disposed(by: dispose)

        let output = Output(devices: devices.asObservable(),
                            isBusy: isBusy,
                            isScanning: peripheralService.scanning.asObservable(),
                            enableScanning: enableScanning.asObservable())
        return output
    }

    private func connectDevice(device: Device) {
        peripheralService.connect(device: device)
    }

    private func disconnectDevice(device: Device) {
        peripheralService.disconnect(device: device)
    }
}
