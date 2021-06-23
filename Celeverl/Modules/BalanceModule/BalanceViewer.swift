//
//  BalanceViewer.swift
//  HappyChild (mobile)
//
//  Created by Евгений on 1/19/20.
//  Copyright © 2020 oberon. All rights reserved.
//

import Foundation
import UIKit

//MARK: - BalanceViewer
public class BalanceViewer: UIViewController, BalanceViewerProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    //MARK: - BalanceViewerProtocol implementation
    public var interactor: BalanceInteractorProtocol?
    
    public func changedStatePage(_ state: Bool) {
        DispatchQueue.main.async {
            if state {
                self.statePageView.startAnimating()
            }
            else {
                self.statePageView.stopAnimating()
            }
        }
    }
    
    public func updateView(_ data: BalanceModel) {
        
        DispatchQueue.main.async {
            let dataForrmater = DateFormatter()
            dataForrmater.dateFormat = "dd.MM.yyyy"
            if let date = dataForrmater.date(from: data.DateEndStr) {
                if date > Date() {
                    self.dataEndView.text = "Действует до \(data.DateEndStr)"
                    self.dataEndView.isHidden = false
                    self.balanceValueView.text = data.HappyChildAnalysisHours > 1 ? "\(data.HappyChildAnalysisHours) часов" : "\(data.HappyChildAnalysisHours) час"
                }
                else {
                    self.dataEndView.isHidden = true
                    self.balanceValueView.text = "Балланс: 0 часов"
                }
            }
            self.historyTitleView.text = "История платежей"
            self.tableHistoryItems = data.History
            self.tableHistoryView.reloadData()
        }
    }
    
    
    //MARK: - Properties
    private var balanceTitleView: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 23)
        label.textColor = .black
        return label
    }()
    
    private var balanceValueView: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppConstants.APP_ROBOTO_MEDIUM, size: 22)
        label.textColor = .black
        return label
    }()
    
    private var historyTitleView: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppConstants.APP_ROBOTO_MEDIUM, size: 23)
        label.textColor = .black
        return label
    }()
    
    private var dataEndView: UILabel = {
        var view = UILabel()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    private var statePageView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.style = .large
        view.color = .white
        return view
    }()
    
    private var tableHistoryItems: [HistoryBalanceModel] = []
    
    private var tableHistoryView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        return view
    }()
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tableHistoryItems.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: BalanceHistoryViewCell.reuqseID, for: indexPath)
        guard let balanceCell = cell as? BalanceHistoryViewCell else { return cell }
        balanceCell.BindingContext = self.tableHistoryItems[indexPath.item]
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.tableHistoryView.bounds.width * 0.9, height: 120)
    }

    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactor?.loadBalanceData()
    }
    
    public override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        self.configuareViews()
    }
    
    private func configuareViews(){
        self.configuareTitleBalanceTitleView()
        self.configuareTitleBalanceValueView()
        self.configaureDateEndView()
        self.configuareHistoryTitleView()
        self.configuareTableHistoryView()
        self.configuareStateView()
    }
    
    private func configuareTitleBalanceValueView(){
        
        self.view.addSubview(self.balanceValueView)
        
        self.balanceValueView.translatesAutoresizingMaskIntoConstraints = false
        self.balanceValueView.leftAnchor.constraint(equalTo: self.balanceTitleView.rightAnchor, constant: 5).isActive = true
        self.balanceValueView.centerYAnchor.constraint(equalTo: self.balanceTitleView.centerYAnchor).isActive = true
    }
    
    private func configuareStateView(){
        
        self.view.addSubview(self.statePageView)
        
        self.statePageView.translatesAutoresizingMaskIntoConstraints = false
        self.statePageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.statePageView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.statePageView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.statePageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func configuareTitleBalanceTitleView(){
        
        self.view.addSubview(self.balanceTitleView)
        
        self.balanceTitleView.translatesAutoresizingMaskIntoConstraints = false
        self.balanceTitleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        self.balanceTitleView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
    }
    
    private func configaureDateEndView(){

        self.view.addSubview(self.dataEndView)

        self.dataEndView.text = ""
        self.dataEndView.translatesAutoresizingMaskIntoConstraints = false
        self.dataEndView.topAnchor.constraint(equalTo: self.balanceValueView.bottomAnchor, constant: 10).isActive = true
        self.dataEndView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.dataEndView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true
    }
    
    private func configuareHistoryTitleView(){
        
        self.view.addSubview(self.historyTitleView)

        self.historyTitleView.translatesAutoresizingMaskIntoConstraints = false
        self.historyTitleView.topAnchor.constraint(equalTo: self.dataEndView.bottomAnchor, constant: 80).isActive = true
        self.historyTitleView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.historyTitleView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true
        
    }
    
    private func configuareTableHistoryView(){

        self.view.addSubview(self.tableHistoryView)
        self.tableHistoryView.delegate = self
        self.tableHistoryView.dataSource = self
        self.tableHistoryView.register(BalanceHistoryViewCell.self, forCellWithReuseIdentifier: BalanceHistoryViewCell.reuqseID)

        self.tableHistoryView.translatesAutoresizingMaskIntoConstraints = false
        self.tableHistoryView.topAnchor.constraint(equalTo: self.historyTitleView.bottomAnchor, constant: 5).isActive = true
        self.tableHistoryView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.tableHistoryView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.tableHistoryView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

    }
    
}
