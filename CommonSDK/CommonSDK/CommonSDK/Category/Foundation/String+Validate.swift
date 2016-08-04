//
//  String+Validate.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/7/1.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public extension String {
    
    /*!
    *  @brief  判断是否全是字母
    */
    func vld_isLetters() -> Bool {
        let regPattern : String = "[a-zA-Z]+";
        let testResult : NSPredicate = NSPredicate(format: "SELF MATCHES %@", regPattern);
        return testResult.evaluateWithObject(self);
    }
    
    /*!
    *  @brief  是否是一个整数型字符串
    */
    func vld_isPureInt() -> Bool {
        let scan : NSScanner = NSScanner(string: self as String);
        var int : CInt = 0;
        return scan.scanInt(&int) && scan.atEnd;
    }
    
    /*!
    *  @brief  是否是合法手机号（忽略空格）
    */
    func vld_isPhoneNumber() -> Bool {
        let txt : String = self.stringByReplacingOccurrencesOfString(" ", withString: "");
        let regPattern : String = "^1[0-9]{10}$";
        let testResult : NSPredicate = NSPredicate(format: "SELF MATCHES %@", regPattern);
        return testResult.evaluateWithObject(txt);
    }
    
    /*!
    *  @brief  是否是合法邮箱
    */
    func vld_isEmail() -> Bool {
        let regPattern : String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
        let testResult : NSPredicate = NSPredicate(format: "SELF MATCHES %@", regPattern);
        return testResult.evaluateWithObject(self);
    }

    /*!
    *  @brief  忽略大小写比较两个字符串
    */
    func vld_equalsIngnoreCase(str:String?) -> Bool {
        if(nil == str) {
            return false;
        }
        
        return self.lowercaseString == str!.lowercaseString;
    }

    /*!
    *  @brief  是否包含指定的字符串
    */
    func vld_contains(str:String?) -> Bool {
        if(nil == str) {
            return false;
        }
        
        return self.containsString(str!);
    }
    
    /*!
    *  @brief  是否是空字符串
    */
    static func vld_isBlank(str:String?) -> Bool {
        if(str == nil) {
            return true;
        }
        
        if(str!.isKindOfClass(NSNull)) {
            return true;
        }

        let newStr : String = str!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
        return newStr.isEmpty;
    }
}
