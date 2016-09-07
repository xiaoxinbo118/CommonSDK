//
//  UIColor+Common.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/9/7.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public extension UIColor {

    public class func cmn_color(R r: NSInteger, G g: NSInteger, B b: NSInteger, A a: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a);
    }
    
    public class func cmn_color(hex aHex: NSInteger, alpha aAlpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat((aHex & 0xFF0000) >> 16) / 255.0, green: CGFloat((aHex & 0xFF00) >> 8) / 255.0, blue: CGFloat((aHex & 0xFF)) / 255.0, alpha: aAlpha);
    }    
}
