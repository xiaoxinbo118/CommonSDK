//
//  CMNButtonBadge.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/9/6.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public enum CMNButtonBadgeStyle: Int {
    case Normal
    case Small
}

/**
 *  有红点提示的按钮
 *
 */
public class CMNButtonBadge: UIButton {
    private let SMALL_WIDTH: CGFloat = 9;
    private let NORMAL_WIDTH: CGFloat = 15;
    private let DEFAULT_BACKGROUND_COLOR: UIColor = UIColor.redColor();
    private let DEFAULT_TEXT_COLOR: UIColor = UIColor.whiteColor();
    private let DEFAULT_BORDER_COLOR: UIColor = UIColor.whiteColor();
    private let DEFAULT_FONT_SIZE: UIFont = UIFont.systemFontOfSize(14);
    
    private var pStyle: CMNButtonBadgeStyle = CMNButtonBadgeStyle.Normal;
    private var pBadgeValue: Int = 0;
    
    public let badgeLabel: UILabel = UILabel();
    public var badgeStyle: CMNButtonBadgeStyle {
        get {
            return pStyle;
        }
        set(value) {
            pStyle = value;
            
            switch(pStyle) {
            case .Small:
                self.badgeLabel.frm_size = CGSizeMake(self.SMALL_WIDTH, self.SMALL_WIDTH);
                break
            default:
                self.badgeLabel.frm_size = CGSizeMake(self.NORMAL_WIDTH, self.NORMAL_WIDTH);
                break
            }
            
            self.badgeLabel.backgroundColor = DEFAULT_BACKGROUND_COLOR;
            self.badgeLabel.textColor = DEFAULT_TEXT_COLOR;
            self.badgeLabel.layer.borderColor = DEFAULT_BORDER_COLOR.CGColor;
            self.badgeLabel.layer.borderWidth = 1;
            self.badgeLabel.textAlignment = NSTextAlignment.Center;
            self.badgeLabel.font = DEFAULT_FONT_SIZE;
            self.badgeLabel.layer.masksToBounds = true;
        }
    }
    
    public var badgeValue: Int {
        get {
            return pBadgeValue;
        }
        set(value) {
            pBadgeValue = max(0, value);
            
            self.badgeLabel.hidden = self.badgeValue == 0;
            if(self.badgeStyle == CMNButtonBadgeStyle.Small) {
                self.badgeLabel.text = "";
                return;
            }
            
            self.badgeLabel.text = self.badgeValue > 99 ? "99+" : String(self.badgeValue);
        }
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.badgeStyle = CMNButtonBadgeStyle.Normal;
        self.badgeLabel.hidden = true;
        self.addSubview(self.badgeLabel);
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews();
        
        self.badgeLabel.layer.cornerRadius = self.badgeLabel.frm_height / 2;
        
        var x: CGFloat = 0;
        var y: CGFloat = 0
        var offsetX: CGFloat = 0;
        var offsetY: CGFloat = 0;
        
        var referView: UIView?;
        
        if (self.imageView?.image != nil) {
            referView = self.imageView;
        } else if (self.titleLabel != nil) {
            referView = self.titleLabel;
        }
        
        if (referView != nil) {
            offsetX = self.badgeStyle == CMNButtonBadgeStyle.Normal ? 0 : -3;
            offsetY = 5;
            
            switch (self.contentHorizontalAlignment) {
            case .Right :
                x = self.frm_width + offsetX;
                y = referView!.frm_top + offsetY;
                break;
            case .Left :
                x = referView!.frm_right + offsetX;
                y = referView!.frm_top + offsetY;
                break;
            default:
                x = referView!.frm_right + offsetX;
                y = referView!.frm_top + offsetY;
                break;
            }
            
            self.badgeLabel.center = CGPointMake(x, y);
        }
    }
}