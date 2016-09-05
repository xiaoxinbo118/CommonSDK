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
    var opt_length : NSInteger {
        get {
            return self.characters.count;
        }
    }
    
    /*!
    *  @brief  安全截取字符串（从第0位到index）
    *
    *  @param index  目标index
    */
    func opt_subStringToIndex(index:NSInteger) -> String {
        if(index < self.opt_length) {
            let stringIndex = self.startIndex.advancedBy(index);
            return self.substringToIndex(stringIndex);
        }
        return self;
    }
    

    /*!
    *  @brief  安全截取字符串（从第index位到最后）
    *
    *  @param index  目标index
    */
    func opt_subStringFromIndex(index:NSInteger) -> String {
        if(index < self.opt_length) {
            let stringIndex = self.startIndex.advancedBy(index);
            return self.substringFromIndex(stringIndex);
        }
        
        return self;
    }

    /*!
    *  @brief nil转""
    *
    *  @param str 字符串
    */
    static func opt_safeString(str: String?) -> String {
        if (String.vld_isBlank(str)) {
            return "";
        } else {
            return str!;
        }
    }
}
