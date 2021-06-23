//
//  AppBarPanel.swift
//  HappyChild
//
//  Created by Евгений on 11/13/19.
//  Copyright © 2019 Oberon. All rights reserved.
//

import Foundation
import UIKit

public class AppBarPanel: UIView {
    
    public var leftView: AppTouchView!
    public var layerLeftView: CAShapeLayer!
    
    public var titleView: UIImageView!
    
    public var rightView: UIImageView!
    
    public var badgeView: UILabel!
    
    public var notificationLayer: CAShapeLayer!
    public var notifictionTextLayer: CATextLayer!
    
    public var menuSize: CGFloat = 40
    
    public var Toggled: ((Bool) -> Void)?
    @objc dynamic public var IsOpen: Bool = false {
        didSet{
            self.updateLeftView()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuareView()
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configuareView(){
        self.createMenuView()
        self.createTitleView()
        self.createNotifyView()
        self.createBadgeView()
    }
    
    private func createMenuView(){
        self.leftView = AppTouchView()
        self.leftView.touchBackgroundColor = UIColor.init(hex: "#95979B", alpha: 0.45)
        self.addSubview(self.leftView)

        self.layerLeftView = CAShapeLayer()
        self.layerLeftView.contentsScale = UIScreen.main.scale
        self.layerLeftView.strokeColor = UIColor.black.cgColor

        self.layerLeftView.fillColor = UIColor.black.cgColor
        self.layerLeftView.lineWidth = 4
        self.layerLeftView.lineCap = .round
        self.leftView.layer.addSublayer(self.layerLeftView)
    
        let gestureRecognizire = UITapGestureRecognizer(target: self, action: #selector(Toggle))
        self.leftView.addGestureRecognizer(gestureRecognizire)
    }
    
    private func configuareLeftView(){
        self.leftView.center = CGPoint(x: 40, y: self.bounds.height/2)
        self.leftView.bounds = CGRect(x: 0, y: 0, width: 40, height: 30)
        self.layerLeftView.bounds = self.layerLeftView.bounds
        self.updateLeftView()
    }
    
    private func updateLeftView(){
        
        let newPath = self.IsOpen ? self.openPath() : self.menuPath()
        
        CATransaction.begin()
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.duration = 0.3
        pathAnimation.fromValue = self.layerLeftView.path
        pathAnimation.toValue = newPath.cgPath
        
        self.layerLeftView.add(pathAnimation, forKey: nil)
        
        CATransaction.setCompletionBlock({
            self.layerLeftView.path = newPath.cgPath
        })
        CATransaction.commit()
    }
    
    private func menuPath() -> UIBezierPath {
        
        let path = UIBezierPath()
        let lineHeight = self.layerLeftView.lineWidth
        path.move(to: CGPoint(x:lineHeight/2, y: lineHeight))
        path.addLine(to: CGPoint(x: self.leftView.bounds.width - lineHeight/2, y: lineHeight))

        path.move(to: CGPoint(x:lineHeight/2, y:self.leftView.bounds.height/2))
        path.addLine(to: CGPoint(x:self.leftView.bounds.width - lineHeight/2, y:self.leftView.bounds.height/2))

        path.move(to: CGPoint(x:lineHeight/2, y:self.leftView.bounds.height - lineHeight))
        path.addLine(to: CGPoint(x:self.leftView.bounds.width - lineHeight/2, y:self.leftView.bounds.height - lineHeight))
        return path
    }
    
    private func openPath() -> UIBezierPath {
        
        let lineHeight = self.layerLeftView.lineWidth
        let path = UIBezierPath()
        path.move(to: CGPoint(x:lineHeight, y:lineHeight))
        path.addLine(to: CGPoint(x:self.leftView.bounds.width - lineHeight, y:self.leftView.bounds.height - lineHeight))
        
        path.move(to: CGPoint(x:self.leftView.bounds.width - lineHeight, y:lineHeight))
        path.addLine(to: CGPoint(x:lineHeight, y:self.leftView.bounds.height - lineHeight))
        return path
    }
    
    private func createTitleView(){
        let image = UIImageView(image: UIImage(named: "black_company"))
        image.contentScaleFactor = UIScreen.main.scale
        image.contentMode = .scaleAspectFit
        self.titleView = image
        self.addSubview(self.titleView)
    }
    
    private func configuareTitleView(){
        self.titleView.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        self.titleView.bounds = CGRect(x: 0, y: 0, width: self.menuSize, height: self.menuSize)
    }
    
    private func createNotifyView(){
        let image = UIImageView(image: UIImage(named: "notification_picture"))
        image.contentScaleFactor = UIScreen.main.scale
        image.contentMode = .scaleAspectFit
        self.rightView = image
        self.addSubview(self.rightView)
    }
    private func configuareRightView(){
        self.rightView.center = CGPoint(x: self.bounds.width-40, y: self.bounds.height/2)
        self.rightView.bounds = CGRect(x: 0, y: 0, width: self.menuSize, height: self.menuSize)
    }
    
    private func createBadgeView(){
        self.badgeView = UILabel()
        self.addSubview(self.badgeView)
    }
    private func configuareBadgeView(){
        self.badgeView.center = CGPoint(x: self.bounds.width - 28, y: self.bounds.height/2 - 10)
        self.badgeView.bounds = CGRect(x: 0, y: 0, width: 20, height: 18)
        self.badgeView.layer.cornerRadius = 9
        self.badgeView.backgroundColor = UIColor.init(red: 253/255, green: 54/255, blue: 36/255, alpha: 1)
        self.badgeView.isHidden = true
        self.badgeView.textColor = UIColor.white
        self.badgeView.textAlignment = NSTextAlignment.center
        self.badgeView.clipsToBounds = true
        badgeView.font = badgeView.font.withSize(12.0)
    }
    public func showBadgeView(flag : Bool){
        if(flag == true){
            self.badgeView.text = String(UIApplication.shared.applicationIconBadgeNumber)
            self.badgeView.isHidden = false
        }else{
            self.badgeView.isHidden = true
        }
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        self.configuareLeftView()
        self.configuareTitleView()
        self.configuareRightView()
        self.configuareBadgeView()
    }
    
    @objc public func Toggle(_ gesture: UIGestureRecognizer){
        self.updateLeftView()
        if let click = self.Toggled {
            click(self.IsOpen)
        }
    }
    

          
}
