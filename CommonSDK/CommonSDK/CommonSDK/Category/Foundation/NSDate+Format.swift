//
//  NSDate+Format.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/8/4.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

var fmt_calendar : NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!;
var fmt_formatter : NSDateFormatter = NSDateFormatter();
var fmt_String : String = "yyyy-MM-dd HH:mm:ss";

public extension NSDate {
    
    func fmt_year() -> NSInteger {
        let components : NSDateComponents = fmt_calendar.components(NSCalendarUnit.Year, fromDate: self);
        return components.year;
    }

    func fmt_month() -> NSInteger {
        let components : NSDateComponents = fmt_calendar.components(NSCalendarUnit.Month, fromDate: self);
        return components.month;
    }

    func fmt_day() -> NSInteger {
        let components : NSDateComponents = fmt_calendar.components(NSCalendarUnit.Day, fromDate: self);
        return components.day;
    }
    
    func fmt_hour() -> NSInteger {
        let components : NSDateComponents = fmt_calendar.components(NSCalendarUnit.Hour, fromDate: self);
        return components.hour;
    }
    
    func fmt_minute() -> NSInteger {
        let components : NSDateComponents = fmt_calendar.components(NSCalendarUnit.Minute, fromDate: self);
        return components.minute;
    }
    
    func fmt_second() -> NSInteger {
        let components : NSDateComponents = fmt_calendar.components(NSCalendarUnit.Second, fromDate: self);
        return components.second;
    }
    
    /*!
    *  @brief 把时间按"yyyy-MM-dd HH:mm:ss"转为字符串
    *
    *  @param format 格式
    *
    */
    func fmt_string() -> String! {
        return self.fmt_stringWithFormat(fmt_String)
    }
    
    /*!
    *  @brief 把时间按指定的格式转为字符串
    *
    *  @param format 格式
    *
    */
    func fmt_stringWithFormat(fmt:String!) -> String {
        fmt_formatter.dateFormat = fmt;
        return fmt_formatter.stringFromDate(self);
    }
    
    /*!
    *  @brief 把字符串按指定的格式转换为时间
    *
    *  @param string 字符
    *  @param format 格式
    *
    */
    static func fmt_dataFromString(string:String?, format fmt:String!) -> NSDate? {
        if(string == nil) {
            return nil;
        }
        fmt_formatter.dateFormat = fmt_String;
        return fmt_formatter.dateFromString(string!);
    }
    
}
