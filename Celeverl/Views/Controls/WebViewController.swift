//
//  WebViewController.swift
//  HappyChild (mobile)
//
//  Created by Евгений on 1/29/20.
//  Copyright © 2020 oberon. All rights reserved.
//

import Foundation
import UIKit
import WebKit

public class WebViewController: UIViewController {
    
    private var webView:WKWebView = {
        var view = WKWebView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    public var url:String = "" {
        didSet{
            self.updatePage()
        }
    }
    
    override public func loadView() {
        super.loadView()
        self.configuareView()
    }
    
    func configuareView(){
        self.view.addSubview(self.webView)
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.webView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.webView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func updatePage(){
        if let url = URL(string: self.url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
}
