import Foundation
import RxCocoa
import RxSwift

public class SearchDevicesViewModel: BaseViewModelProtocol {
    struct Input {
        var searchDeviceTextField: BehaviorSubject<String>
        var startScan: PublishSubject<Void>
        var stopScan: PublishSubject<Void>
        var goToDevice: BehaviorSubject<Device>
        var connectDevice: BehaviorSubject<Int>
        var disconnectDevice: BehaviorSubject<Device>
    }

    struct Output {
        var devices: Observable<[Device]>
        var isBusy: Observable<Bool>
        var isEnable: Observable<Bool>
    }

    typealias Device = PeripheralModel

    typealias InputViewModel = Input

    typealias OutputViewModel = Output

    var input: Input

    var devices: BehaviorSubject<[Device]>

    var isBusy: Observable<Bool>

    var enableScanning: BehaviorSubject<Bool>

    var dispose = DisposeBag()

    private var peripheralService: PeriperalService

    init(inputModel: Input,
         devicesObservable: BehaviorSubject<[Device]>,
         busyObservable: BehaviorSubject<Bool>,
         enableScanningObservable: BehaviorSubject<Bool>,
         deviceService: PeriperalService)
    {
        peripheralService = deviceService
        devices = devicesObservable
        isBusy = busyObservable
        enableScanning = enableScanningObservable
        input = inputModel
    }

    convenience init(input: Input,
                     devices: BehaviorSubject<[Device]> = .init(value: []),
                     isBusy: BehaviorSubject<Bool> = .init(value: false),
                     enable: BehaviorSubject<Bool> = .init(value: false))
    {
        self.init(inputModel: input,
                  devicesObservable: devices,
                  busyObservable: isBusy,
                  enableScanningObservable: enable,
                  deviceService: PeriperalService.shared)
    }

    func configure() -> Output {
        input.connectDevice.subscribe { [weak self] event in
            guard let self = self, let index = event.element else {
                return
            }

        }.disposed(by: dispose)

        input.disconnectDevice.subscribe { [weak self] event in
            guard let self = self, let device = event.element else {
                return
            }
            self.disconnectDevice(device: device)
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
            if state == .poweredOn {
                self.enableScanning.onNext(true)
            } else {
                self.enableScanning.onNext(false)
            }
        }.disposed(by: dispose)

        return Output(devices: devices.asObservable(),
                      isBusy: isBusy.asObservable(),
                      isEnable: enableScanning.asObservable())
    }

    private func connectDevice(device: Device) {
        peripheralService.connect(device: device)
    }

    private func disconnectDevice(device: Device) {
        peripheralService.disconnect(device: device)
    }
}
