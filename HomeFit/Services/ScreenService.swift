//
//  ScreenService.swift
//  HomeFit
//
//  Created by Евгений on 3/8/21.
//

import UIKit


public class ScreenService {
    
    public static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public static func getWidth(_ percent: CGFloat) -> CGFloat {
        return self.width * CGFloat(percent / 100)
    }
    
    public static func getHeight(_ percent: CGFloat) -> CGFloat {
        return self.height * CGFloat(percent / 100)
    }
    
}
