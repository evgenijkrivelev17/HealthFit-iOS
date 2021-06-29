import RxCocoa
import RxSwift
import UIKit

class SearchDevicesController: BaseViewController<SearchDevicesViewModel> {
    var perehiralsTable: UITableView = {
        var table = UITableView()
        table.rowHeight = UITableView.automaticDimension
        table.register(PeripheralCell.self, forCellReuseIdentifier: PeripheralCell.idCell)
        return table
    }()

    var scanButton: UIButton = {
        var button = UIButton()
        button.setTitle("Scan", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = ScreenService.getWidth(10)
        return button
    }()

    var stopButton: UIButton = {
        var button = UIButton()
        button.setTitle("Stop", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = ScreenService.getWidth(10)
        return button
    }()

    var busyIndicator: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            view.style = .large
        } else {
            view.style = .whiteLarge
        }
        view.color = .black
        return view
    }()

    var foundDeviceTitle: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "Founded devices:"
        return label
    }()

    let disposeBag = DisposeBag()

    override func setUpUI() {
        setUpFoundTitle()
        setUpPeripheralTableUI()
        setUpScanButtonUI()
        setUpBusyIndidicatorUI()
    }

    func setUpFoundTitle() {
        view.addSubview(foundDeviceTitle)
        foundDeviceTitle.frame = CGRect(x: ScreenService.getWidth(5),
                                        y: ScreenService.getHeight(5),
                                        width: ScreenService.getWidth(45),
                                        height: ScreenService.getHeight(5))
    }

    func setUpPeripheralTableUI() {
        view.addSubview(perehiralsTable)
        perehiralsTable.frame = CGRect(x: 0,
                                       y: foundDeviceTitle.frame.maxY,
                                       width: ScreenService.getWidth(100),
                                       height: ScreenService.getHeight(90))
    }

    func setUpScanButtonUI() {
        view.addSubview(scanButton)
        scanButton.frame = CGRect(x: ScreenService.getWidth(50) - ScreenService.getWidth(10),
                                  y: ScreenService.getHeight(85),
                                  width: ScreenService.getWidth(20),
                                  height: ScreenService.getWidth(20))
    }

    func setUpBusyIndidicatorUI() {
        view.addSubview(busyIndicator)
        busyIndicator.frame = CGRect(x: ScreenService.getWidth(95) - ScreenService.getWidth(5),
                                     y: ScreenService.getHeight(5),
                                     width: ScreenService.getWidth(5),
                                     height: ScreenService.getWidth(5))
    }

    init(viewModel model: SearchDevicesViewModel) {
        super.init(model: model)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func bindViewModel() {
        perehiralsTable.rx.setDelegate(self).disposed(by: disposeBag)

        let output = viewModel.configure(input: SearchDevicesViewModel.Input(searchDeviceTextField: BehaviorSubject<String>.init(value: "sample"),
                                                                             startScan: scanButton.rx.tap.asObservable(),
                                                                             stopScan: stopButton.rx.tap.asObservable(),
                                                                             goToDevice: PublishSubject<PeripheralModel>.init(),
                                                                             connectDevice: perehiralsTable.rx.itemSelected.asObservable(),
                                                                             disconnectDevice: PublishSubject<IndexPath>.init()))

        _ = output.isBusy.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                guard let self = self else {
                    return
                }
                if state {
                    self.busyIndicator.startAnimating()
                } else {
                    self.busyIndicator.stopAnimating()
                }
            }).disposed(by: disposeBag)

        _ = output.devices.map { [weak self] devices in
            "Founded devices: \(devices.count)"
        }.observe(on: MainScheduler.instance)
            .bind(to: foundDeviceTitle.rx.text)
            .disposed(by: disposeBag)

        output.devices.bind(to: perehiralsTable.rx
            .items(cellIdentifier: PeripheralCell.idCell, cellType: PeripheralCell.self)) { _, model, cell in
                cell.setData(to: model)
        }.disposed(by: disposeBag)
    }
}

// MARK: - Extension UITableViewDelegate

extension SearchDevicesController: UITableViewDelegate {}
