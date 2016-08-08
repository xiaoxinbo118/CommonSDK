//
//  UITextField.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/8/5.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public extension UITextField {
    
//[input addTarget:input action:@selector(sf_input_did_change_action:) forControlEvents:UIControlEventEditingChanged];
    
    /**
     *  输入的最大宽度
     */
    var easy_maxLength : NSInteger {
        get {
            let result : AnyObject? = self.rtm_associatedObjectForKey("easy_maxLength");
            
            if(result == nil) {
                return 0;
            } else {
                return result!.integerValue;
            }
        }
        set(newValue) {
            self.text = self.text?.opt_subStringToIndex(newValue);
            self .easy_addInputDidChangedTarget();
            self .rtm_associateCopyAtomicObject(NSNumber(integer: newValue), key: "easy_maxLength");
        }
    }
    
    /**
     *  字符限定
     */
    var easy_characterLimit : NSCharacterSet? {
        get {
            let result = self.rtm_associatedObjectForKey("easy_characterLimit");
            return result as? NSCharacterSet;
        }
        set(newValue) {
            if(!String.vld_isBlank(self.text) && newValue != nil) {
                self.text = self.text!.fmt_substringMeetCharacterSet(newValue);
            }
            self .easy_addInputDidChangedTarget();
            self .rtm_associateCopyAtomicObject(newValue, key: "easy_characterLimit");
        }
    }
    
    private func easy_addInputDidChangedTarget() {
        self.removeTarget(self, action: Selector("easy_inputDidChangedAction"), forControlEvents: UIControlEvents.EditingChanged);
        self.addTarget(self, action: Selector("easy_inputDidChangedAction"), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    private func easy_inputDidChangedAction() {
        if(self.markedTextRange != nil) {
            return;
        }
        
        let text : String? = self.text;
        if(String.vld_isBlank(text)) {
            return;
        }
        
        
        
    }
}
