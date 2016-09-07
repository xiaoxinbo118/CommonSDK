//
//  UIView+EasyFrame.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/8/4.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public extension UIView {
    
    public var frm_origin : CGPoint {
        get {
            return self.frame.origin;
        }
        set(newValue) {
            var frame : CGRect = self.frame;
            frame.origin = newValue;
            self.frame = frame;
        }
    }
    
    public var frm_size : CGSize {
        get {
            return self.frame.size;
        }
        set(newValue) {
            var frame : CGRect = self.frame;
            frame.size = newValue;
            self.frame = frame;
        }
    }
    
    public var frm_width : CGFloat {
        get {
            return self.frame.size.width;
        }
        set(newValue) {
            var size : CGSize = self.frm_size;
            size.width = newValue;
            self.frm_size = size;
        }
    }

    public var frm_height : CGFloat {
        get {
            return self.frame.size.height;
        }
        set(newValue) {
            var size : CGSize = self.frm_size;
            size.height = newValue;
            self.frm_size = size;
        }
    }
    
    
    public var frm_left : CGFloat {
        get {
            return self.frame.origin.x;
        }
        set(newValue) {
            var origin : CGPoint = self.frm_origin;
            origin.x = newValue;
            self.frm_origin = origin;
        }
    }
    
    public var frm_right : CGFloat {
        get {
            return CGRectGetMaxX(self.frame);
        }
        set(newValue) {
            var origin : CGPoint = self.frm_origin;
            origin.x = newValue - self.frm_width;
            self.frm_origin = origin;
        }
    }
    
    public var frm_top : CGFloat {
        get {
            return self.frame.origin.y;
        }
        set(newValue) {
            var origin : CGPoint = self.frm_origin;
            origin.y = newValue;
            self.frm_origin = origin;
        }
    }

    public var frm_bottom : CGFloat {
        get {
            return CGRectGetMaxY(self.frame);
        }
        set(newValue) {
            var origin : CGPoint = self.frm_origin;
            origin.y = newValue - self.frm_height;
            self.frm_origin = origin;
        }
    }
}
