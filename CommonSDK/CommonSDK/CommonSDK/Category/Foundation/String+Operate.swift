//
//  String+Operate.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/8/5.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public extension String {
    
    /*!
    *  @brief 字符串长度
    */
    public var opt_length : NSInteger {
        get {
            return self.characters.count;
        }
    }
    
    /*!
    *  @brief  安全截取字符串（从第0位到index）
    *
    *  @param index  目标index
    */
    public func opt_subString(toIndex index:NSInteger) -> String {
        if(index < self.opt_length) {
            let stringIndex = self.characters.index(self.startIndex, offsetBy: index);
            return self.substring(to: stringIndex);
        }
        return self;
    }
    

    /*!
    *  @brief  安全截取字符串（从第index位到最后）
    *
    *  @param index  目标index
    */
    public func opt_subString(fromIndex index:NSInteger) -> String {
        if(index < self.opt_length) {
            let stringIndex = self.characters.index(self.startIndex, offsetBy: index);
            return self.substring(from: stringIndex);
        }
        
        return self;
    }

    /*!
    *  @brief nil转""
    *
    *  @param str 字符串
    */
    public static func opt_safeString(_ str: String?) -> String {
        if (String.vld_isBlank(str)) {
            return "";
        } else {
            return str!;
        }
    }
}
