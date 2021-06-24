//
//  ViewController.swift
//  HomeFit
//
//  Created by Евгений on 2/9/21.
//

import UIKit
import RxSwift
import RxCocoa
import CoreBluetooth

class ViewController: UIViewController, UITableViewDelegate  {
   
    
    //MARK: - UI Elements
    var perehiralsTable: UITableView = {
        var table = UITableView()
        table.rowHeight = UITableView.automaticDimension
        table.register(PeripheralCell.self, forCellReuseIdentifier: PeripheralCell.IdCell)
        return table
    }()
    
    var scanButton: UIButton = {
        var button = UIButton()
        button.setTitle("Scan", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = ScreenService.getWidth(10)
        return button
    }()
    
    var busyIndicator: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView()
        view.style = .medium
        view.color = .black
        return view
    }()
    
    var foundDeviceTitle:UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "Founded devices:"
        return label
    }()
    
    let disposeBag = DisposeBag()
    
    
    override func loadView() {
        super.loadView()
        self.setUpUI()
    }
    
    
    func setUpUI(){
        self.setUpFoundTitle()
        self.setUpPeripheralTableUI()
        self.setUpScanButtonUI()
        self.setUpBusyIndidicatorUI()
    }
    
    func setUpFoundTitle(){
        self.view.addSubview(self.foundDeviceTitle)
        self.foundDeviceTitle.frame = CGRect(x: ScreenService.getWidth(5),
                                             y: ScreenService.getHeight(5),
                                             width: ScreenService.getWidth(45),
                                             height: ScreenService.getHeight(5))
    }
    
    func setUpPeripheralTableUI(){
        self.view.addSubview(self.perehiralsTable)
        self.perehiralsTable.frame = CGRect(x: 0,
                                            y: self.foundDeviceTitle.frame.maxY,
                                            width: ScreenService.getWidth(100),
                                            height: ScreenService.getHeight(90))
    }
    
    func setUpScanButtonUI(){
        self.view.addSubview(self.scanButton)
        self.scanButton.frame = CGRect(x: ScreenService.getWidth(50) - ScreenService.getWidth(10),
                                       y: ScreenService.getHeight(85),
                                       width: ScreenService.getWidth(20),
                                       height: ScreenService.getWidth(20))
    }
    
    func setUpBusyIndidicatorUI(){
        self.view.addSubview(self.busyIndicator)
        self.busyIndicator.frame = CGRect(x: ScreenService.getWidth(95) - ScreenService.getWidth(5),
                                          y: ScreenService.getHeight(5),
                                          width: ScreenService.getWidth(5),
                                          height: ScreenService.getWidth(5))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLogics()
        
    }
    
    func setUpLogics(){
        
//        _ = PeriperalService.shared.foundDevices.map({ (devices) -> String in
//            return "Founded devices: \(devices)"
//        }).bind(to: self.foundDeviceTitle.rx.text).disposed(by: self.disposeBag)
//
//        self.perehiralsTable.rx.setDelegate(self).disposed(by: disposeBag)
        
        
//        _ = PeriperalService.shared.foundDevices
//            .bind(to: self.perehiralsTable.rx
//                    .items(cellIdentifier: PeripheralCell.ID_CELL, cellType: PeripheralCell.self)) { row, model, cell in
//                cell.setData(to: model)
//            }.disposed(by: self.disposeBag)
//
//
//
//
//        self.perehiralsTable.rx.itemSelected.subscribe { (index) in
//
//        }.disposed(by: self.disposeBag)
//
//
//        _ = self.scanButton.rx.tap.subscribe { (e) in
//            PeriperalService.shared.startScanning()
//        }.disposed(by: self.disposeBag)
        
        
//        _ = PeriperalService.shared.isScanning.observe(on: MainScheduler.instance).subscribe(onNext: { (state) in
//            state ? self.busyIndicator.startAnimating() : self.busyIndicator.stopAnimating()
//        }).disposed(by: self.disposeBag)
        
    }
}


