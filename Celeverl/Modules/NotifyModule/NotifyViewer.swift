//
//  NotifyViewer.swift
//  Celeverl
//
//  Created by Евгений on 2/13/20.
//  Copyright © 2020 oberon. All rights reserved.
//

import Foundation
import UIKit

//MARK: - NotifyViewer
public class NotifyViewer: UIViewController, NotifyViewerProtocol, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - NotifyViewerProtocol implementation
    public var interactor: NotifyInteractorProtocol?
    public var router: NotifyRouterProtocol?
    
    public var notifications: [NotificationModel]  = []
    public var groupingNotifications: [(Date,[NotificationModel])] = []{
        didSet {
            DispatchQueue.main.async {
                self.notificationsCollection.reloadData()
            }
        }
    }
    
    public func updateNotifications(_ notification: [NotificationModel]) {
        self.notifications = notification
        
        DispatchQueue.main.async {
            if (self.notifications.count > 0) {
                self.emprtyTitleView.isHidden = true
            } else {
                self.emprtyTitleView.isHidden = false
            }
        }
        self.groupNotifications()
    }
    
    private func groupNotifications(){
        
        let formmater = DateFormatter()
        formmater.dateFormat = "MM-dd-yyyy HH:mm"
        let anotherForrmater = DateFormatter()
        anotherForrmater.dateFormat = "MM/dd/yyyy"
        
        self.groupingNotifications = Dictionary(grouping: self.notifications){ (notify) -> Date in
            
            let data = formmater.date(from: notify.usersDateStr!)!
            let str = anotherForrmater.string(from: data)
            let shortData = anotherForrmater.date(from: str)!
            return shortData
        }
        .sorted(){ (prev,next) in prev.key > next.key }
        
    }
    
    public func showError(error: String) {
        
    }
    
    public func hideError() {
        
    }
    
    public func changedBusyState(_ state: Bool) {
        DispatchQueue.main.async {
            if (state) {
                self.busyView.startAnimating()
            } else {
                self.busyView.stopAnimating()
            }
        }
    }
    
    
    //MARK: - Properties
    public var backButtonView: UIImageView!
    public var notificationTitleView: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 22)
        label.textColor = .black
        label.text = "Последние нотификации"
        return label
    }()
    public var notificationsCollection: UITableView = {
        var table = UITableView()
        table.separatorStyle = .none
        return table
    }()
    
    public var busyView: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView()
        view.style = .large
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.85)
        view.color = .white
        return view
    }()
    
    public var emprtyTitleView: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: AppConstants.APP_ROBOTO_REGULAR, size: 20)
        label.textColor = .systemGray
        label.text = "В данный момент нет нотификаций"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.confgiaureViews()
        self.interactor?.getNotifications()
    }

    override public func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func confgiaureViews(){
        self.configuareBackButton()
        self.configuareTitleView()
        self.configuateTableView()
        self.configuateEmptyTitleView()
        self.configuareBusyView()
    }
    
    private func configuareBackButton(){

        self.backButtonView = UIImageView(image: UIImage(named: "arrow_back"))
        self.backButtonView.isUserInteractionEnabled = true
        self.view.addSubview(self.backButtonView)
        
        self.backButtonView.translatesAutoresizingMaskIntoConstraints = false
        self.backButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.backButtonView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.backButtonView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        self.backButtonView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        
        self.backButtonView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backToPrevious))
        self.backButtonView.addGestureRecognizer(tapGesture)
    }
    
    private func configuareTitleView(){
        self.view.addSubview(self.notificationTitleView)
        
        self.notificationTitleView.translatesAutoresizingMaskIntoConstraints = false
        
        self.notificationTitleView.centerYAnchor.constraint(equalTo: self.backButtonView.centerYAnchor).isActive = true
        self.notificationTitleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    
    private func configuareBusyView(){
        self.view.addSubview(self.busyView)
        self.busyView.translatesAutoresizingMaskIntoConstraints = false
        self.busyView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.busyView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.busyView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.busyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    
    private func configuateTableView(){
        self.view.addSubview(self.notificationsCollection)
        
        self.notificationsCollection.register(NotificationViewCell.self, forCellReuseIdentifier: NotificationViewCell.resueseId)
        self.notificationsCollection.translatesAutoresizingMaskIntoConstraints = false
        self.notificationsCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.notificationsCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.notificationsCollection.topAnchor.constraint(equalTo: self.notificationTitleView.bottomAnchor, constant: 20).isActive = true
        self.notificationsCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.notificationsCollection.delegate = self
        self.notificationsCollection.dataSource = self
    }
    
    private func configuateEmptyTitleView(){
        self.view.addSubview(self.emprtyTitleView)
        self.emprtyTitleView.translatesAutoresizingMaskIntoConstraints = false
        self.emprtyTitleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.emprtyTitleView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.emprtyTitleView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    @objc private func backToPrevious(){
        self.interactor?.back()
    }
    
    
    //MARK: - Table functions
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if( section < self.groupingNotifications.count){
            return self.groupingNotifications[section].1.count
        }
        else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.notificationsCollection.dequeueReusableCell(withIdentifier: NotificationViewCell.resueseId, for: indexPath)
        cell.selectionStyle = .none
        if let model = cell as? NotificationViewCell {
            model.BindingContext = self.groupingNotifications[indexPath.section].1[indexPath.row]
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = AppPaddingLabel(withInsets: 5,5, 5, 5)
        label.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 14)
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        
        let containerView = UIView()
        containerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
        
       
        if let notify = self.groupingNotifications[section].1.first {
            label.text = notify.creationTimeUsers

            let formmater = DateFormatter()
            formmater.dateFormat = "MM-dd-yyyy HH:mm"
            let anotherForrmater = DateFormatter()
            anotherForrmater.dateFormat = "MM.dd.yyyy"
            let data = formmater.date(from: notify.usersDateStr!)!
            let str = anotherForrmater.string(from: data)
            label.text = str
        }
        return containerView
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.groupingNotifications.count
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
