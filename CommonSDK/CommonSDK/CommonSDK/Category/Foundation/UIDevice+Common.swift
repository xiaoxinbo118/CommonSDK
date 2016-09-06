//
//  UIDevice+Common.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/9/2.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public extension UIDevice {
    
    /**
     *  iOS version 8.0以及以上
     *
     *  @param block 执行的block
     */
    class func cmn_isVersion8OrAbove() -> Bool {
        let version: NSString = UIDevice.currentDevice().systemVersion as NSString;
        return version.floatValue >= 8.0;
    }
    
    /**
     *  是否是iphone4的尺寸
     *
     *  @param block 执行的block
     */
    class func cmn_isIphone4() -> Bool {
        if (UIScreen.mainScreen().currentMode == nil) {
            return false;
        } else {
            return CGSizeEqualToSize(CGSizeMake(640, 960), UIScreen.mainScreen().currentMode!.size);
        }
    }
    
    /**
     *  是否是iphone5的尺寸
     *
     *  @param block 执行的block
     */
    class func cmn_isIphone5() -> Bool {
        if (UIScreen.mainScreen().currentMode == nil) {
            return false;
        } else {
            return CGSizeEqualToSize(CGSizeMake(640, 1136), UIScreen.mainScreen().currentMode!.size);
        }
    }
    
    /**
     *  是否是iphone6的尺寸
     *
     *  @param block 执行的block
     */
    class func cmn_isIphone6() -> Bool {
        if (UIScreen.mainScreen().currentMode == nil) {
            return false;
        } else {
            return CGSizeEqualToSize(CGSizeMake(1242, 2208), UIScreen.mainScreen().currentMode!.size);
        }
    }
    
}
