//
//  UIViewController+NavigationBar.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/9/6.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

/**
 *  方便设置navigationController左右按钮
 */
public extension UIViewController {
    
    /**
     *  系统按钮点击区域比较大， 此View用来调节按钮点击区域
     */
    private class Nav_NavigationBarView: UIView {
        var touchedEdgeInsets: UIEdgeInsets = UIEdgeInsetsZero;
        
        override private func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
            let result = super.pointInside(point, withEvent: event);
            
            if (result) {
                return result;
            } else {
                let rect = UIEdgeInsetsInsetRect(self.bounds, self.touchedEdgeInsets);
                return CGRectContainsPoint(rect, point);
            }
        }
    }

    /**
     *  返回前一画面事件
     */
    public func nav_back() {
        self.nav_controller()?.popViewControllerAnimated(true);
    }
    
    /**
     *  获取导航栏的标题
     */
    public func nav_title() -> String? {
        let view: UIView? = self.nav_controller()?.navigationItem.titleView;
        
        if let label = view as? UILabel {
            return label.text;
        } else {
            return nil;
        }
    }
    
    /**
     *  设置导航栏的标题（默认主题色）
     *
     *  @param text 标题内容
     */
    public func nav_setTitle(text aText: String) {
        self.nav_setTitle(text: aText, textColor: UIColor.blackColor());
    }
    
    /**
     *  设置导航栏的标题
     *
     *  @param text 标题内容
     *  @param textColor 标题颜色
     */
    public func nav_setTitle(text aText: String, textColor aTextColor: UIColor) {
        if (aText == self.nav_title()) {
            return;
        }
        
        let titleLabel: UILabel = UILabel(frame: CGRectMake(0, 0, 100, 30));
        titleLabel.textAlignment = NSTextAlignment.Center;
        titleLabel.textColor = aTextColor;
        titleLabel.text = aText;
        titleLabel.font = UIFont.systemFontOfSize(24);
        
        self.nav_controller()?.navigationItem.titleView = titleLabel;
    }
    
    /**
     *  清空左侧按钮
     */
    public func nav_clearLeftButton() {
        let btn: UIButton = UIButton(type: UIButtonType.Custom);
        btn.frame = CGRectMake(0, 0, 15, 44);
        let baritem = UIBarButtonItem(customView: btn);
        
        self.nav_controller()?.navigationItem.leftBarButtonItem = baritem;
        self.nav_controller()?.navigationItem.backBarButtonItem = baritem;
    }

    /**
     *  清空右侧按钮
     */
    public func nav_clearRightButton() {
        self.nav_controller()?.navigationItem.rightBarButtonItem = nil;
    }
    
    /**
     *  设置左侧按钮
     *
     *  @param image 按钮图片
     *  @return 按钮
     */
    public func nav_setLeftButton(image aImage: UIImage) -> CMNButtonBadge {
        return self.nav_setLeftButton(text: "", textColor: nil, image: aImage, target: self, action: Selector("nav_back"));
    }

    /**
     *  设置左侧按钮
     *
     *  @param image 按钮图片
     *  @param action 点击事件
     *  @return 按钮
     */
    public func nav_setLeftButton(image aImage: UIImage, action aAction: Selector) -> CMNButtonBadge {
        return self.nav_setLeftButton(text: "", textColor: nil, image: aImage, target: self, action: aAction);
    }

    /**
     *  设置左侧按钮
     *
     *  @param text 按钮title
     *  @param textColor 按钮title颜色
     *  @param action 点击事件
     *  @return 按钮
     */
    public func nav_setLeftButton(text aText: String?, textColor aTextColor: UIColor?, action aAction: Selector) -> CMNButtonBadge {
        return self.nav_setLeftButton(text: aText, textColor: aTextColor, image: nil, target: self, action: aAction);
    }

    /**
     *  设置左侧按钮
     *
     *  @param text 按钮title
     *  @param textColor 按钮title颜色
     *  @param image 按钮图片
     *  @param target 事件拥有者
     *  @param action 点击事件
     *  @return 按钮
     */
    public func nav_setLeftButton(text aText: String?, textColor aTextColor: UIColor?, image aImage: UIImage?, target aTarget: AnyObject, action aAction: Selector) -> CMNButtonBadge {
        
        var btn: CMNButtonBadge?;
        let barItem: UIBarButtonItem = self.nav_barButtonItem(text: aText, textColor: aTextColor, image: aImage, align: UIControlContentHorizontalAlignment.Left, target: aTarget, action: aAction, button: &btn!);
        
        self.nav_controller()?.navigationItem.leftBarButtonItem = barItem;
        return btn!;
    }
    
    /**
     *  设置右侧按钮（两个）
     *
     *  @param image1 第一个按钮图片
     *  @param action1 第一个按钮事件
     *  @param image2 第二个按钮图片
     *  @param action2 第二个按钮事件
     *  @return [按钮1， 按钮2]
     */
    public func nav_setRightButton(image1 aImage1: UIImage, action1 aAction1: Selector, image2 aImage2: UIImage, action2 aAction2: Selector) -> [CMNButtonBadge] {
        return self.nav_setRightButton(image1: aImage1, action1: aAction1, target1: self, image2: aImage2, target2: self, action2: aAction2);
    }

    /**
     *  设置右侧按钮（两个）
     *
     *  @param image1 第一个按钮图片
     *  @param action1 第一个按钮事件
     *  @param target1 第一个事件拥有者
     *  @param image2 第二个按钮图片
     *  @param action2 第二个按钮事件
     *  @param target2 第二个事件拥有者
     *  @return [按钮1， 按钮2]
     */
    public func nav_setRightButton(image1 aImage1: UIImage, action1 aAction1: Selector, target1 aTarget1: AnyObject, image2 aImage2: UIImage, target2 aTarget2: AnyObject, action2 aAction2: Selector) -> [CMNButtonBadge] {
        var btn1: CMNButtonBadge?;
        let barItem1: UIBarButtonItem = self.nav_barButtonItem(text: "", textColor: nil, image: aImage1, align: UIControlContentHorizontalAlignment.Right, target: self, action: aAction1, button: &btn1!);
        var btn2: CMNButtonBadge?;
        let barItem2: UIBarButtonItem = self.nav_barButtonItem(text: "", textColor: nil, image: aImage2, align: UIControlContentHorizontalAlignment.Right, target: self, action: aAction2, button: &btn2!);

        self.nav_controller()?.navigationItem.rightBarButtonItems = [barItem1, barItem2];
        
        return [btn1!, btn2!];
    }
    
    /**
     *  设置右侧按钮
     *
     *  @param textColor 按钮title颜色
     *  @param target 事件拥有者
     *  @param action 点击事件
     *  @return 按钮
     */
    public func nav_setRightButton(image aImage: UIImage, action aAction: Selector) -> CMNButtonBadge {
        return self.nav_setRightButton(text: "", textColor: nil, image: aImage, target: self, action: aAction);
    }
    
    /**
     *  设置右侧按钮
     *
     *  @param text 按钮title
     *  @param textColor 按钮title颜色
     *  @param action 点击事件
     *  @return 按钮
     */
    public func nav_setRightButton(text aText: String?, textColor aTextColor: UIColor?, action aAction: Selector) -> CMNButtonBadge {
        return self.nav_setRightButton(text: aText, textColor: aTextColor, image: nil, target: self, action: aAction);
    }

    /**
     *  设置右侧按钮
     *
     *  @param text 按钮title
     *  @param textColor 按钮title颜色
     *  @param image 按钮图片
     *  @param target 事件拥有者
     *  @param action 点击事件
     *  @return 按钮
     */
    public func nav_setRightButton(text aText: String?, textColor aTextColor: UIColor?, image aImage: UIImage?, target aTarget: AnyObject, action aAction: Selector) -> CMNButtonBadge {
        
        var btn: CMNButtonBadge?;
        let barItem: UIBarButtonItem = self.nav_barButtonItem(text: aText, textColor: aTextColor, image: aImage, align: UIControlContentHorizontalAlignment.Right, target: aTarget, action: aAction, button: &btn!);
        
        self.nav_controller()?.navigationItem.leftBarButtonItem = barItem;
        return btn!;
    }
    
    /**
     *  生成导航拦按钮
     *
     *  @param text 按钮title
     *  @param textColor 按钮title颜色
     *  @param image 按钮图片
     *  @param align 排列方式
     *  @param target 事件拥有者
     *  @param action 点击事件
     *  @param button 按钮
     *  @return 按钮BarItem
     */
    private func nav_barButtonItem(text aText: String?, textColor aTextColor: UIColor?, image aImage: UIImage?, align horizontalAlign:UIControlContentHorizontalAlignment, target aTarget: AnyObject, action aAction: Selector, inout button btn: CMNButtonBadge) -> UIBarButtonItem {
        
        var frame: CGRect = CGRectMake(0, 7, 80, 30);
        if (aImage != nil) {
            frame = CGRectMake(0, 0, aImage!.size.width, aImage!.size.height);
        }

        btn = CMNButtonBadge(frame: frame);
        btn.frame = frame;
        btn.contentHorizontalAlignment = horizontalAlign;
        btn.easy_normalImage = aImage;
        btn.easy_normalTitle = aText ?? "";
        
        if (aTextColor != nil) {
            btn.easy_normalTitleColor = aTextColor!;
        }
        
        btn.easy_addTouchUpInsideEvent(aTarget, SEL: aAction);
        
        let view = Nav_NavigationBarView(frame: frame);
        
        if (horizontalAlign == UIControlContentHorizontalAlignment.Left) {
            view.touchedEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        } else {
            view.touchedEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
        }

        return UIBarButtonItem(customView: view);
    }
    
    private func nav_controller() -> UINavigationController? {
        if (self.parentViewController != nil
            && !self.parentViewController!.isKindOfClass(UINavigationController.classForCoder())) {
            return self.parentViewController?.navigationController;
        } else {
            return self.navigationController;
        }
    }
}
