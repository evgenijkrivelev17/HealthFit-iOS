//
//  DocumentViewer.swift
//  HappyChild (mobile)
//
//  Created by Евгений on 1/23/20.
//  Copyright © 2020 oberon. All rights reserved.
//

import Foundation
import UIKit

//MARK: - DocumentViewerProtocol
public class DocumentViewer: UIViewController, DocumentViewerProtocol, UITableViewDelegate, UITableViewDataSource {
   
    //MARK: - DocumentViewerProtocol implementation
    public var interactor: DocumentInteractorProtocol?
    
    public func updateDocuments(_ data: [DocumentModel]) {
        self.Documents = data
        self.checkStateEmptyTitleView()
    }
    
    public func updatePageState(_ state: Bool) {
        self.changePageState(state)
    }
    
    private func changePageState(_ state: Bool) {
        DispatchQueue.main.async {
            if (state) {
                self.busyView.startAnimating()
            }
            else {
                self.busyView.stopAnimating()
            }
        }
    }
    
    private var Documents:[DocumentModel] = [] {
        didSet {
            self.groupDocuments()
        }
    }
    
    //MARK: - Properties
    private let documentTitleView: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: AppConstants.APP_ROBOTO_BOLD, size: 22)
        label.textColor = .black
        return label
    }()
    private let busyView: UIActivityIndicatorView = {
        var activity = UIActivityIndicatorView()
        activity.style = .large
        activity.color = .white
        activity.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.85)
        return activity
    }()
    private let documentsTableView: UITableView = {
        var table = UITableView()
        table.register(DocumentViewCell.self, forCellReuseIdentifier: DocumentViewCell.resueseId)
        table.separatorStyle = .none
        return table
    }()
    private let emptyTitleView:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppConstants.APP_ROBOTO_MEDIUM, size: 23)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    public var groupingDocuments: [(Date,[DocumentModel])] = [] {
       didSet {
           DispatchQueue.main.async {
               self.documentsTableView.reloadData()
           }
       }
    }
    
    private func groupDocuments(){
           
        let formmater = DateFormatter()
        formmater.dateFormat = "dd-MM-yyyy"
        
        let anotherForrmater = DateFormatter()
        anotherForrmater.dateFormat = "MM/dd/yyyy"

        self.groupingDocuments = Dictionary(grouping: self.Documents){ (document) -> Date in
            let str = anotherForrmater.string(from: document.date)
            let shortData = anotherForrmater.date(from: str)!
            return shortData
        }
        .sorted(){ (prev,next) in prev.key > next.key }
        print(self.groupingDocuments)
    }
    
    override public func loadView() {
        super.loadView()
        self.configuareView()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactor?.loadData()
    }
    
    
    private func configuareView(){
        self.configuareDocumentTitleView()
        self.configuareDocumentTableView()
        self.configuareEmptyTitleView()
        self.configuareBusyStatePageView()
    }
    
    private func configuareDocumentTitleView(){
        self.view.addSubview(self.documentTitleView)
        self.documentTitleView.translatesAutoresizingMaskIntoConstraints = false
        self.documentTitleView.text = "Отчеты"
        self.documentTitleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15).isActive = true
        self.documentTitleView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
    }
    
    private func configuareDocumentTableView(){
        self.view.addSubview(self.documentsTableView)
        self.documentsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.documentsTableView.delegate = self
        self.documentsTableView.dataSource = self
        self.documentsTableView.topAnchor.constraint(equalTo: self.documentTitleView.bottomAnchor, constant: 10).isActive = true
        self.documentsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
        self.documentsTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        self.documentsTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        self.documentsTableView.estimatedRowHeight = UITableView.automaticDimension
        self.documentsTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func configuareBusyStatePageView(){
        self.view.addSubview(self.busyView)
        self.busyView.translatesAutoresizingMaskIntoConstraints = false
        self.busyView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.busyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.busyView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.busyView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
    }
    
    private func configuareEmptyTitleView(){
        self.view.addSubview(self.emptyTitleView)
        
        self.emptyTitleView.translatesAutoresizingMaskIntoConstraints = false
        
        self.emptyTitleView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        self.emptyTitleView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        
        self.emptyTitleView.topAnchor.constraint(equalTo: self.documentTitleView.bottomAnchor, constant: 30).isActive = true
        
        self.emptyTitleView.isHidden = true
    }
    
    
    private func checkStateEmptyTitleView(){
        DispatchQueue.main.async {
            if self.Documents.count > 0 {
                self.emptyTitleView.isHidden = false
            }
            else {
                self.emptyTitleView.isHidden = true
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if( section < self.groupingDocuments.count) {
               return self.groupingDocuments[section].1.count
           }
           else {
               return 0
           }
       }
       
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.documentsTableView.dequeueReusableCell(withIdentifier: DocumentViewCell.resueseId, for: indexPath)
        if let documentCell = cell as? DocumentViewCell {
            documentCell.BindingContext = self.groupingDocuments[indexPath.section].1[indexPath.row]
        }
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.groupingDocuments[indexPath.section].1.count {
            let document = self.groupingDocuments[indexPath.section].1[indexPath.row]
            self.openDocumentInBrowser(document)
        }
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

        if let document = self.groupingDocuments[section].1.first {
            label.text = document.dateStr
            let anotherForrmater = DateFormatter()
            anotherForrmater.dateFormat = "MM.dd.yyyy"
            let shortStr = anotherForrmater.string(from: document.date)
            label.text = shortStr
        }
        return containerView
    }
    
    private func openDocumentInBrowser(_ document: DocumentModel) {
        DispatchQueue.main.async {
            guard let url = document.UrlToWatch else { return }
            let page = WebViewController()
            page.url = url
            self.present(page, animated: true, completion: nil)
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
           return self.groupingDocuments.count
    }
    
}
