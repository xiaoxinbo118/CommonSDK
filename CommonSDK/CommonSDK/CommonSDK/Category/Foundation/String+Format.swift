//
//  String+Format.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/8/2.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit


public extension String {

    /*!
    *  @brief  全部符合集合的子字符串，若传入nil返回当前string
    *
    *  @param set 集合
    */
    public func fmt_substringMeetCharacterSet(_ set: CharacterSet?) -> String {
        if(set == nil) {
            return self;
        }
        
        let mutableString : NSMutableString = NSMutableString(string: self);
        
        let text : NSString = NSString(string: self);
        
        for index in 0 ..< text.length {
            let c : unichar = text.character(at: index);
            if(set!.contains(UnicodeScalar(c)!)) {
                mutableString.appendFormat("%C", c);
            }
        }
        
        return mutableString.copy() as! String;
    }
}
