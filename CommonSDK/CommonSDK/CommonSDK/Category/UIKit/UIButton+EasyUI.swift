//
//  UIButton+EasyUI.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/9/5.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public extension UIButton {
    
    /**
     *  normal下的title
     */
    public var easy_normalTitle: String {
        get {
            return String.opt_safeString(self.title(for: UIControlState.normal));
        }
        set(value) {
            self.setTitle(value, for: UIControlState.normal);
        }
    }
    
    /**
     *  设置normal下的titleColor
     */
    public var easy_normalTitleColor: UIColor {
        get {
            let color: UIColor? = self.titleColor(for: UIControlState.normal);
            return color == nil ? UIColor.white : color!;
        }
        set (value) {
            self.setTitleColor(value, for: UIControlState.normal);
        }
    }
    
    /**
     *  设置normal下的image
     */
    public var easy_normalImage: UIImage? {
        get {
            return self.image(for: UIControlState.normal);
        }
        set (value) {
            self.setImage(value, for: UIControlState.normal);
        }
    }
    
    /**
     *  设置normal下的backgroud image
     */
    public var easy_normalBackgroundImage: UIImage? {
        get {
            return self.backgroundImage(for: UIControlState.normal);
        }
        set (value) {
            self.setBackgroundImage(value, for: UIControlState.normal);
        }
    }
    
    /**
    *  设置highlighted/selected下的title
    */
    public var easy_selectedTitle: String {
        get {
            return String.opt_safeString(self.title(for: UIControlState.highlighted));
        }
        set(value) {
            self.setTitle(value, for: UIControlState.highlighted);
            self.setTitle(value, for: UIControlState.selected);
        }
    }
    
    /**
     *  设置highlighted/selected下的titleColor
     */
    public var easy_selectedTitleColor: UIColor {
        get {
            let color: UIColor? = self.titleColor(for: UIControlState.highlighted);
            return color == nil ? UIColor.white : color!;
        }
        set (value) {
            self.setTitleColor(value, for: UIControlState.highlighted);
            self.setTitleColor(value, for: UIControlState.selected);
        }
    }
    
    /**
     *  设置highlighted/selected下的image
     */
    public var easy_selectedImage: UIImage? {
        get {
            return self.image(for: UIControlState.highlighted);
        }
        set (value) {
            self.setImage(value, for: UIControlState.highlighted);
            self.setImage(value, for: UIControlState.selected);
        }
    }
    
    /**
     *  设置normal下的backgroud backgroundImage
     */
    public var easy_selectedBackgroundImage: UIImage? {
        get {
            return self.backgroundImage(for: UIControlState.highlighted);
        }
        set (value) {
            self.setBackgroundImage(value, for: UIControlState.highlighted);
            self.setBackgroundImage(value, for: UIControlState.selected);
        }
    }
    
    /**
     *  设置disabled下的title
     */
    public var easy_disabledTitle: String {
        get {
            return String.opt_safeString(self.title(for: UIControlState.disabled));
        }
        set(value) {
            self.setTitle(value, for: UIControlState.disabled);
        }
    }
    
    /**
     *  设置disabled下的titleColor
     */
    public var easy_disabledTitleColor: UIColor {
        get {
            let color: UIColor? = self.titleColor(for: UIControlState.disabled);
            return color == nil ? UIColor.white : color!;
        }
        set (value) {
            self.setTitleColor(value, for: UIControlState.disabled);
        }
    }
    
    /**
     *  设置disabled下的image
     */
    public var easy_disabledImage: UIImage? {
        get {
            return self.image(for: UIControlState.disabled);
        }
        set (value) {
            self.setImage(value, for: UIControlState.disabled);
        }
    }
    
    /**
     *  设置disabled下的backgroud backgroundImage
     */
    public var easy_disabledBackgroundImage: UIImage? {
        get {
            return self.backgroundImage(for: UIControlState.disabled);
        }
        set (value) {
            self.setBackgroundImage(value, for: UIControlState.disabled);
        }
    }
    
    /**
     *  添加点击事件
     *
     *  @param target   事件执行者
     *  @param SEL 事件方法
     */
    public func easy_addTouchUpInsideEvent(_ target: AnyObject, SEL: Selector) {
        
        if(target.responds(to: SEL)) {
            self.addTarget(target, action: SEL, for: UIControlEvents.touchUpInside);
        }
    }
}
