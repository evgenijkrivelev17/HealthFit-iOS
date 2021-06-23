//
//  ContainerViewController.swift
//  HappyChild (mobile)
//
//  Created by Евгений on 11/22/19.
//  Copyright © 2019 oberon. All rights reserved.
//

import Foundation
import UIKit

public class MenuViewer: UIViewController, MenuViewerProtocol, SelectedMenuItemDelegate {
    
    //MARK: - MenuViewerProtocol implementation
    public var interactor: MenuInteractorProtocol?
    
    public func changedMenuItem(item: MenuModel) {
        self.selectMenuDelegate?.selectedMenuItemDelegate(item)
        self.selectedMenuItem = item
    }
    
    public func getListMenuItems(_ list: [MenuModel]) {
        self.menuItems = list
        self.updateMenuListView()
    }
    
    //MARK: - Properties
    var menuItems: [MenuModel] = []
    var menuItemsView: [UIView] = []
    
    var selectedMenuItem: MenuModel?
    var selectMenuDelegate: SelectedMenuItemDelegate?
    
    override public func loadView() {
        super.loadView()
        self.interactor?.loadDefaultData()
        self.view.backgroundColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
     
    
   func selectedMenuItemDelegate(_ item: BaseModel) {
       if self.selectMenuDelegate != nil, let menuItem = item as? MenuModel {
            self.interactor?.changeMenuItem(item: menuItem)
       }
   }
    
    private func updateMenuListView(){
        DispatchQueue.main.async {
            self.clearMenuViews()
            self.menuItems.forEach(){ self.createItemMenu($0)}
        }
    }
    
    private func createItemMenu(_ menuItem: MenuModel) {
        
        let menuView = AppCustomButton()
        menuView.title = menuItem.Name
        menuView.titleLabel?.font = UIFont(name: AppConstants.APP_AVENIR_BOLD, size: 22)
        menuView.backgroundColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        menuView.titleLabel?.numberOfLines = 2
        menuView.titleLabel?.lineBreakMode = .byWordWrapping
        menuView.contentHorizontalAlignment = .left
        menuView.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        menuView.setTitleColor(.black, for: .normal)
        
        self.view.addSubview(menuView)
        
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        menuView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        menuView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        if self.menuItemsView.count == 0 {
            menuView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        }
        else {
            menuView.topAnchor.constraint(equalTo: self.menuItemsView[self.menuItemsView.count-1].bottomAnchor, constant: 0).isActive = true
        }
        self.menuItemsView.append(menuView)
        
        menuView.Action = {(_) in
            self.selectedMenuItemDelegate(menuItem)
        }
    }
    
    private func clearMenuViews(){
        self.menuItemsView.forEach(){ $0.removeFromSuperview( )}
        self.menuItemsView.removeAll()
    }
}

