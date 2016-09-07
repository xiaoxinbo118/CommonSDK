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
    public func fmt_substringMeetCharacterSet(set: NSCharacterSet?) -> String {
        if(set == nil) {
            return self;
        }
        
        let mutableString : NSMutableString = NSMutableString(string: self);
        
        let text : NSString = NSString(string: self);
        for(var index : NSInteger = 0; index < text.length; index++) {
            let c : unichar = text.characterAtIndex(index);
            if(set!.characterIsMember(c)) {
                mutableString.appendFormat("%C", c);
            }
        }
        
        return mutableString.copy() as! String;
    }
}
