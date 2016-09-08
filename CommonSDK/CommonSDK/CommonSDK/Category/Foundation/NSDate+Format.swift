//
//  NSDate+Format.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/8/4.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

var fmt_calendar : Calendar = Calendar(identifier: Calendar.Identifier.gregorian);
var fmt_formatter : DateFormatter = DateFormatter();
var fmt_String : String = "yyyy-MM-dd HH:mm:ss";

public extension Date {
    
    public func fmt_year() -> NSInteger {
        let components : DateComponents = (fmt_calendar as NSCalendar).components(NSCalendar.Unit.year, from: self);
        return components.year!;
    }

    public func fmt_month() -> NSInteger {
        let components : DateComponents = (fmt_calendar as NSCalendar).components(NSCalendar.Unit.month, from: self);
        return components.month!;
    }

    public func fmt_day() -> NSInteger {
        let components : DateComponents = (fmt_calendar as NSCalendar).components(NSCalendar.Unit.day, from: self);
        return components.day!;
    }
    
    public func fmt_hour() -> NSInteger {
        let components : DateComponents = (fmt_calendar as NSCalendar).components(NSCalendar.Unit.hour, from: self);
        return components.hour!;
    }
    
    public func fmt_minute() -> NSInteger {
        let components : DateComponents = (fmt_calendar as NSCalendar).components(NSCalendar.Unit.minute, from: self);
        return components.minute!;
    }
    
    public func fmt_second() -> NSInteger {
        let components : DateComponents = (fmt_calendar as NSCalendar).components(NSCalendar.Unit.second, from: self);
        return components.second!;
    }
    
    /*!
    *  @brief 把时间按"yyyy-MM-dd HH:mm:ss"转为字符串
    *
    *  @param format 格式
    *
    */
    public func fmt_string() -> String! {
        return self.fmt_stringWithFormat(fmt_String)
    }
    
    /*!
    *  @brief 把时间按指定的格式转为字符串
    *
    *  @param format 格式
    *
    */
    public func fmt_stringWithFormat(_ fmt:String!) -> String {
        fmt_formatter.dateFormat = fmt;
        return fmt_formatter.string(from: self);
    }
    
    /*!
    *  @brief 把字符串按指定的格式转换为时间
    *
    *  @param string 字符
    *  @param format 格式
    *
    */
    public static func fmt_dataFromString(_ string:String?, format fmt:String!) -> Date? {
        if(string == nil) {
            return nil;
        }
        fmt_formatter.dateFormat = fmt_String;
        return fmt_formatter.date(from: string!);
    }
    
}
