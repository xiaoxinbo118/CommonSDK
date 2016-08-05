//
//  UITextField.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/8/5.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public extension UITextField {
    
    /**
     *  输入的最大宽度
     */
    var easy_maxLength : NSInteger {
        get {
            return self.rtm_associatedObjectForKey("easy_maxLength").integerValue;
        }
        set(newValue) {
            self.text = self.text?.opt_subStringToIndex(newValue);
            self .rtm_associateCopyAtomicObject(NSNumber(integer: newValue), key: "easy_maxLength");
        }
    }
    

}
