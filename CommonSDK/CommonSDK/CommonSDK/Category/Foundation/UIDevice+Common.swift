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
    public class func cmn_isVersion8OrAbove() -> Bool {
        let version: NSString = UIDevice.current.systemVersion as NSString;
        return version.floatValue >= 8.0;
    }
    
    /**
     *  是否是iphone4的尺寸
     *
     *  @param block 执行的block
     */
    public class func cmn_isIphone4() -> Bool {
        if (UIScreen.main.currentMode == nil) {
            return false;
        } else {
            return CGSize(width: 640, height: 960).equalTo(UIScreen.main.currentMode!.size);
        }
    }
    
    /**
     *  是否是iphone5的尺寸
     *
     *  @param block 执行的block
     */
    public class func cmn_isIphone5() -> Bool {
        if (UIScreen.main.currentMode == nil) {
            return false;
        } else {
            return CGSize(width: 640, height: 1136).equalTo(UIScreen.main.currentMode!.size);
        }
    }
    
    /**
     *  是否是iphone6的尺寸
     *
     *  @param block 执行的block
     */
    public class func cmn_isIphone6() -> Bool {
        if (UIScreen.main.currentMode == nil) {
            return false;
        } else {
            return CGSize(width: 1242, height: 2208).equalTo(UIScreen.main.currentMode!.size);
        }
    }
    
}
