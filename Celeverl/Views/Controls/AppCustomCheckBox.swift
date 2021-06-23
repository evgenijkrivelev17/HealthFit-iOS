//
//  AppCustomCheckBox.swift
//  HappyChild
//
//  Created by Евгений on 11/16/19.
//  Copyright © 2019 Oberon. All rights reserved.
//

import Foundation
import UIKit

public class AppCustomCheckBox : UIView {
    
    private var Layer:CAShapeLayer!
    public var TIME_ANIMATION: TimeInterval = 0.2
    
    public var cornerRadius: CGFloat = 5{
        didSet{
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    public var state: Bool = false {
        didSet{
            self.updateView()
            self.OnChanged?(self.state)
        }
    }
    
    public var OnChanged: ((_ state:Bool) -> Void)?
    
    public var selectedColor: UIColor = UIColor.black
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.cornerRadius
        self.createLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.configuareLayer()
    }
    
    
    public func createLayer(){
        self.Layer = CAShapeLayer()
        self.Layer.contentsScale = UIScreen.main.scale
        self.Layer.lineWidth = 3
        self.Layer.lineCap = .round
        self.Layer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(self.Layer)
    }
    
    private func configuareLayer(){
        self.Layer.frame = self.bounds
        self.updateView()
    }
    
    private func updateView(){
        if self.state{
            self.Selected()
        }
        else{
            self.nonSelected()
        }
    }
    
     public func Selected(){
        let newPath = UIBezierPath()
        newPath.move(to: CGPoint(x: self.bounds.width * 0.25, y: self.bounds.height*0.5))
        newPath.addLine(to: CGPoint(x: self.bounds.width*0.5, y: self.bounds.height*0.75))
        newPath.addLine(to: CGPoint(x: self.bounds.width*0.8, y: self.bounds.height*0.25))
        
        CATransaction.begin()
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = self.Layer.path
        pathAnimation.toValue = newPath
        
        let strokeAnimation = CABasicAnimation(keyPath: "strokeColor")
        strokeAnimation.fromValue = self.Layer.strokeColor
        strokeAnimation.toValue = UIColor.white.cgColor
        
        let backgroundColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        backgroundColorAnimation.fromValue = self.Layer.backgroundColor
        backgroundColorAnimation.toValue = UIColor.black.cgColor
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = self.TIME_ANIMATION
        groupAnimation.repeatCount = 0
        groupAnimation.animations = [pathAnimation, strokeAnimation,  backgroundColorAnimation]
        
        self.Layer.add(groupAnimation, forKey: nil)
        CATransaction.setCompletionBlock({
            self.Layer.strokeColor = UIColor.white.cgColor
            self.Layer.path = newPath.cgPath
            self.Layer.backgroundColor = UIColor.black.cgColor
        })
        CATransaction.commit()
    }
    
    public func nonSelected(){
        let newPath = UIBezierPath(roundedRect: self.bounds,
           byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
           cornerRadii: CGSize(width: self.cornerRadius, height: self.cornerRadius))

        CATransaction.begin()
            let pathAnimation = CABasicAnimation(keyPath: "path")
            pathAnimation.fromValue = self.Layer.path
            pathAnimation.toValue = newPath

            let strokeAnimation = CABasicAnimation(keyPath: "strokeColor")
            strokeAnimation.fromValue = self.Layer.strokeColor
            strokeAnimation.toValue = UIColor.black.cgColor

            let backgroundColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
            backgroundColorAnimation.fromValue = self.Layer.backgroundColor
            backgroundColorAnimation.toValue = UIColor.clear.cgColor

            let groupAnimation = CAAnimationGroup()
            groupAnimation.duration = self.TIME_ANIMATION
            groupAnimation.repeatCount = 0
            groupAnimation.animations = [pathAnimation, strokeAnimation,  backgroundColorAnimation]

            self.Layer.add(groupAnimation, forKey: nil)
        CATransaction.setCompletionBlock({
            self.Layer.strokeColor = UIColor.black.cgColor
            self.Layer.path = newPath.cgPath
            self.Layer.backgroundColor = UIColor.clear.cgColor
        })
        CATransaction.commit()
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.state = !self.state
    }
}
