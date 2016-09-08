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
    public var easy_maxLength : NSInteger {
        get {
            let result : AnyObject? = self.rtm_associatedObjectForKey("easy_maxLength");
            
            if(result == nil) {
                return 0;
            } else {
                return result!.intValue;
            }
        }
        
        set(newValue) {
            self.text = self.text?.opt_subString(toIndex: newValue);
            self .easy_addInputDidChangedTarget();
            self .rtm_associateCopyAtomicObject(NSNumber(value: newValue as Int), key: "easy_maxLength");
        }
    }
    
    /**
     *  字符限定
     */
    public var easy_characterLimit : CharacterSet? {
        get {
            let result = self.rtm_associatedObjectForKey("easy_characterLimit");
            return result as? CharacterSet;
        }
        set(newValue) {
            if(!String.vld_isBlank(self.text) && newValue != nil) {
                self.text = self.text!.fmt_substringMeetCharacterSet(newValue);
            }
            self .easy_addInputDidChangedTarget();
            self .rtm_associateCopyAtomicObject(newValue as AnyObject, key: "easy_characterLimit");
        }
    }
    
    fileprivate func easy_addInputDidChangedTarget() {
        self.removeTarget(self, action: #selector(easy_inputDidChangedAction), for: UIControlEvents.editingChanged);
        self.addTarget(self, action:  #selector(easy_inputDidChangedAction), for: UIControlEvents.editingChanged)
    }
    
    @objc fileprivate func easy_inputDidChangedAction() {
        if(self.markedTextRange != nil) {
            return;
        }
        
        var text : String? = self.text;
        if(String.vld_isBlank(text)) {
            return;
        }
        
        let maxLength: NSInteger = self.easy_maxLength;
        if(maxLength > 0 && text!.opt_length < maxLength) {
            text = text?.opt_subString(fromIndex: maxLength);
        }
        
        let set: CharacterSet? = self.easy_characterLimit;
        if(set != nil) {
            let result: String = text!.trimmingCharacters(in: set!);
            if (result.opt_length > 0) {//需要过滤
                text = text?.fmt_substringMeetCharacterSet(set);
            }
        }
        
        self.text = text;
    }
}
