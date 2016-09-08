//
//  CMNButtonBadge.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/9/6.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public enum CMNButtonBadgeStyle: Int {
    case normal
    case small
}

/**
 *  有红点提示的按钮
 *
 */
open class CMNButtonBadge: UIButton {
    fileprivate let SMALL_WIDTH: CGFloat = 9;
    fileprivate let NORMAL_WIDTH: CGFloat = 15;
    fileprivate let DEFAULT_BACKGROUND_COLOR: UIColor = UIColor.red;
    fileprivate let DEFAULT_TEXT_COLOR: UIColor = UIColor.white;
    fileprivate let DEFAULT_BORDER_COLOR: UIColor = UIColor.white;
    fileprivate let DEFAULT_FONT_SIZE: UIFont = UIFont.systemFont(ofSize: 14);
    
    fileprivate var pStyle: CMNButtonBadgeStyle = CMNButtonBadgeStyle.normal;
    fileprivate var pBadgeValue: Int = 0;
    
    open let badgeLabel: UILabel = UILabel();
    open var badgeStyle: CMNButtonBadgeStyle {
        get {
            return pStyle;
        }
        set(value) {
            pStyle = value;
            
            switch(pStyle) {
            case .small:
                self.badgeLabel.frm_size = CGSize(width: self.SMALL_WIDTH, height: self.SMALL_WIDTH);
                break
            default:
                self.badgeLabel.frm_size = CGSize(width: self.NORMAL_WIDTH, height: self.NORMAL_WIDTH);
                break
            }
            
            self.badgeLabel.backgroundColor = DEFAULT_BACKGROUND_COLOR;
            self.badgeLabel.textColor = DEFAULT_TEXT_COLOR;
            self.badgeLabel.layer.borderColor = DEFAULT_BORDER_COLOR.cgColor;
            self.badgeLabel.layer.borderWidth = 1;
            self.badgeLabel.textAlignment = NSTextAlignment.center;
            self.badgeLabel.font = DEFAULT_FONT_SIZE;
            self.badgeLabel.layer.masksToBounds = true;
        }
    }
    
    open var badgeValue: Int {
        get {
            return pBadgeValue;
        }
        set(value) {
            pBadgeValue = max(0, value);
            
            self.badgeLabel.isHidden = self.badgeValue == 0;
            if(self.badgeStyle == CMNButtonBadgeStyle.small) {
                self.badgeLabel.text = "";
                return;
            }
            
            self.badgeLabel.text = self.badgeValue > 99 ? "99+" : String(self.badgeValue);
        }
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.badgeStyle = CMNButtonBadgeStyle.normal;
        self.badgeLabel.isHidden = true;
        self.addSubview(self.badgeLabel);
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
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
        
        if let referView = referView {
            offsetX = self.badgeStyle == CMNButtonBadgeStyle.normal ? 0 : -3;
            offsetY = 5;
            
            switch (self.contentHorizontalAlignment) {
            case .right :
                x = self.frm_width + offsetX;
                y = referView.frm_top + offsetY;
                break;
            case .left :
                x = referView.frm_right + offsetX;
                y = referView.frm_top + offsetY;
                break;
            default:
                x = referView.frm_right + offsetX;
                y = referView.frm_top + offsetY;
                break;
            }
            
            self.badgeLabel.center = CGPoint(x: x, y: y);
        }
    }
}
