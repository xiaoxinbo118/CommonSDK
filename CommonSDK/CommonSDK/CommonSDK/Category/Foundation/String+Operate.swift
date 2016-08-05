//
//  String+Operate.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/8/5.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public extension String {
    var opt_length : NSInteger {
        get {
            return self.characters.count;
        }
    }
    
    /*!
    *  @brief  安全截取字符串（从第0位到index）
    *
    *  @param index  目标index
    *  @param key   key
    */
    func opt_subStringToIndex(index:NSInteger) -> String {
        if(index < self.opt_length) {
            let stringIndex = self.startIndex.advancedBy(index);
            return self.substringToIndex(stringIndex);
        }
        
        return self;
    }
}
