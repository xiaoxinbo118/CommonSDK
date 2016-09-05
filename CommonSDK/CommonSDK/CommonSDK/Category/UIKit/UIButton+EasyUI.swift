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
    var easy_normalTitle: String {
        get {
            return String.opt_safeString(self.titleForState(UIControlState.Normal));
        }
        set(value) {
            self.setTitle(value, forState: UIControlState.Normal);
        }
    }
    
    /**
     *  设置normal下的titleColor
     */
    var easy_normalTitleColor: UIColor {
        get {
            let color: UIColor? = self.titleColorForState(UIControlState.Normal);
            return color == nil ? UIColor.whiteColor() : color!;
        }
        set (value) {
            self.setTitleColor(value, forState: UIControlState.Normal);
        }
    }
    
    /**
     *  设置normal下的image
     */
    var easy_normalImage: UIImage? {
        get {
            return self.imageForState(UIControlState.Normal);
        }
        set (value) {
            self.setImage(value, forState: UIControlState.Normal);
        }
    }
    
    /**
     *  设置normal下的backgroud image
     */
    var easy_normalBackgroundImage: UIImage? {
        get {
            return self.backgroundImageForState(UIControlState.Normal);
        }
        set (value) {
            self.setBackgroundImage(value, forState: UIControlState.Normal);
        }
    }
    
    /**
    *  设置highlighted/selected下的title
    */
    var easy_selectedTitle: String {
        get {
            return String.opt_safeString(self.titleForState(UIControlState.Highlighted));
        }
        set(value) {
            self.setTitle(value, forState: UIControlState.Highlighted);
            self.setTitle(value, forState: UIControlState.Selected);
        }
    }
    
    /**
     *  设置highlighted/selected下的titleColor
     */
    var easy_selectedTitleColor: UIColor {
        get {
            let color: UIColor? = self.titleColorForState(UIControlState.Highlighted);
            return color == nil ? UIColor.whiteColor() : color!;
        }
        set (value) {
            self.setTitleColor(value, forState: UIControlState.Highlighted);
            self.setTitleColor(value, forState: UIControlState.Selected);
        }
    }
    
    /**
     *  设置highlighted/selected下的image
     */
    var easy_selectedImage: UIImage? {
        get {
            return self.imageForState(UIControlState.Highlighted);
        }
        set (value) {
            self.setImage(value, forState: UIControlState.Highlighted);
            self.setImage(value, forState: UIControlState.Selected);
        }
    }
    
    /**
     *  设置normal下的backgroud backgroundImage
     */
    var easy_selectedBackgroundImage: UIImage? {
        get {
            return self.backgroundImageForState(UIControlState.Highlighted);
        }
        set (value) {
            self.setBackgroundImage(value, forState: UIControlState.Highlighted);
            self.setBackgroundImage(value, forState: UIControlState.Selected);
        }
    }
    
    /**
     *  设置disabled下的title
     */
    var easy_disabledTitle: String {
        get {
            return String.opt_safeString(self.titleForState(UIControlState.Disabled));
        }
        set(value) {
            self.setTitle(value, forState: UIControlState.Disabled);
        }
    }
    
    /**
     *  设置disabled下的titleColor
     */
    var easy_disabledTitleColor: UIColor {
        get {
            let color: UIColor? = self.titleColorForState(UIControlState.Disabled);
            return color == nil ? UIColor.whiteColor() : color!;
        }
        set (value) {
            self.setTitleColor(value, forState: UIControlState.Disabled);
        }
    }
    
    /**
     *  设置disabled下的image
     */
    var easy_disabledImage: UIImage? {
        get {
            return self.imageForState(UIControlState.Disabled);
        }
        set (value) {
            self.setImage(value, forState: UIControlState.Disabled);
        }
    }
    
    /**
     *  设置disabled下的backgroud backgroundImage
     */
    var easy_disabledBackgroundImage: UIImage? {
        get {
            return self.backgroundImageForState(UIControlState.Disabled);
        }
        set (value) {
            self.setBackgroundImage(value, forState: UIControlState.Disabled);
        }
    }
    
}
