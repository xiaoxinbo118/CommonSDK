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
    public func vld_isLetters() -> Bool {
        let regPattern : String = "[a-zA-Z]+";
        let testResult : NSPredicate = NSPredicate(format: "SELF MATCHES %@", regPattern);
        return testResult.evaluate(with: self);
    }
    
    /*!
    *  @brief  是否是一个整数型字符串
    */
    public func vld_isPureInt() -> Bool {
        let scan : Scanner = Scanner(string: self as String);
        var int : CInt = 0;
        return scan.scanInt32(&int) && scan.isAtEnd;
    }
    
    /*!
    *  @brief  是否是合法手机号（忽略空格）
    */
    public func vld_isPhoneNumber() -> Bool {
        let txt : String = self.replacingOccurrences(of: " ", with: "");
        let regPattern : String = "^1[0-9]{10}$";
        let testResult : NSPredicate = NSPredicate(format: "SELF MATCHES %@", regPattern);
        return testResult.evaluate(with: txt);
    }
    
    /*!
    *  @brief  是否是合法邮箱
    */
    public func vld_isEmail() -> Bool {
        let regPattern : String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
        let testResult : NSPredicate = NSPredicate(format: "SELF MATCHES %@", regPattern);
        return testResult.evaluate(with: self);
    }

    /*!
    *  @brief  忽略大小写比较两个字符串
    */
    public func vld_equalsIngnoreCase(_ str:String?) -> Bool {
        if(nil == str) {
            return false;
        }
        
        return self.lowercased() == str!.lowercased();
    }

    /*!
    *  @brief  是否包含指定的字符串
    */
    public func vld_contains(_ str:String?) -> Bool {
        if(nil == str) {
            return false;
        }
        
        return self.contains(str!);
    }
    
    /*!
    *  @brief  是否是空字符串
    */
    public static func vld_isBlank(_ str:String?) -> Bool {
        if(str == nil) {
            return true;
        }
        
        if(str!.isKind(of: NSNull.self)) {
            return true;
        }

        let newStr : String = str!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
        return newStr.isEmpty;
    }
}
