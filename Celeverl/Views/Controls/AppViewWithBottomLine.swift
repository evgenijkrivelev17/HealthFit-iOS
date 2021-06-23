//
//  AppViewWithBottomLine.swift
//  Celeverl
//
//  Created by Евгений on 2/12/20.
//  Copyright © 2020 oberon. All rights reserved.
//

import Foundation
import UIKit

public class AppViewWithBottomLine: UIView {
    
    public var IsDrawLine: Bool = true
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        self.drawBottomLine(rect: rect)
    }
    
    private func drawBottomLine(rect: CGRect){
        if self.IsDrawLine {
            let heightLine:CGFloat = 4
            let shapeLine = CAShapeLayer()
            shapeLine.strokeColor = UIColor.black.cgColor
            shapeLine.lineWidth = heightLine
            
            var path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: rect.height - heightLine/2))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height - heightLine/2))
            
            shapeLine.path = path.cgPath
            shapeLine.lineCap = .round
            
            self.layer.addSublayer(shapeLine)
        }
    }
}
