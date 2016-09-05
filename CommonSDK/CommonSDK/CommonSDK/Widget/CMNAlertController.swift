//
//  CMNAlertController.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/9/2.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public enum CMNAlertControllerStyle : Int {
    case ActionSheet
    case Alert

    func convert() -> UIAlertControllerStyle {
        switch self {
        case .ActionSheet :
            return UIAlertControllerStyle.ActionSheet;
        default :
            return UIAlertControllerStyle.Alert;
        }
    }
}

public enum CMNAlertActionStyle : Int {
    case Default
    case Cancel
    case Destructive
    
    func convert() -> UIAlertActionStyle {
        switch self {
        case .Cancel :
            return UIAlertActionStyle.Cancel;
        case .Destructive :
            return UIAlertActionStyle.Destructive;
        default :
            return UIAlertActionStyle.Default;
        }
    }
}

/**
 *  AlertController的按钮元素
 *
 */
public class CMNAlertAction: NSObject {
    var title: String;
    var style: CMNAlertActionStyle;
    var action: ((alertAction: CMNAlertAction) -> Void)?;
    
    /**
     *  初始化（action通过addAction添加）
     *
     *  @param title 标题
     *  @param style 类型
     *  @param action 事件
     */
    public init(title aTitle: String, style aStyle: CMNAlertActionStyle, action aAction: ((alertAction: CMNAlertAction) -> Void)?) {
        self.title = aTitle;
        self.style = aStyle;
        self.action = aAction;
        
        super.init();
    }
    
    func performAction() {
        if(self.action != nil) {
            self.action!(alertAction: self);
        }
        self.action = nil;
    }
}

/**
 *  支持iOS7的AlertController
 *
 */
public class CMNAlertController: NSObject, UIAlertViewDelegate, UIActionSheetDelegate {
    private var actions: [CMNAlertAction] = [];
    private var adaptiveAlert: AnyObject?;
    private var pStyle: CMNAlertControllerStyle;
    private var alertViewController: CMNAlertController?; // 自己引用自己，防止被释放， 主要用在iOS7.0的情况
    
    
    var style: CMNAlertControllerStyle {
        get {
            return pStyle;
        }
    };
    
    /**
     *  初始化（action通过addAction添加）
     *
     *  @param title 标题
     *  @param message 内容
     *  @param style 类型
     */
    required public init(title aTitle: String?, message aMessage: String?, style aStyle:CMNAlertControllerStyle) {
        self.pStyle = aStyle;
        super.init();
        self.initAlert(title: aTitle, message: aMessage);
    }

    /**
     *  初始化（Alert, 一个按钮）
     *
     *  @param title 标题
     *  @param message 内容
     *  @param confirmTitle 按钮名称
     *  @param confirm 按钮点击事件
     */
    convenience public init(title aTitle: String?, message aMessage: String?, confirmTitle aConfirmTitle: String, confirmAction confirm: ((alertAction: CMNAlertAction) -> Void)?) {
        self.init(title: aTitle, message: aMessage, style: CMNAlertControllerStyle.Alert);
        
        self.addAction(CMNAlertAction(title: aConfirmTitle, style: CMNAlertActionStyle.Default, action: confirm));
    }

    /**
     *  初始化（Alert, 两个个按钮， 标题默认为取消、确定）
     *
     *  @param title 标题
     *  @param message 内容
     *  @param cancelAction 取消点击事件
     *  @param confirmAction 确定点击事件
     */
    convenience public init(title aTitle: String?, message aMessage: String?, cancelAction cancel: ((alertAction: CMNAlertAction) -> Void)?, confirmAction confirm: ((alertAction: CMNAlertAction) -> Void)?) {
        self.init(title: aTitle, message: aMessage, cancelTitle: "取消", cancelAction: cancel, confirmTitle: "确定", confirmAction: confirm);
    }

    /**
     *  初始化（Alert, 两个个按钮）
     *
     *  @param title 标题
     *  @param message 内容
     *  @param cancelTitle 取消按钮名称
     *  @param cancelAction 取消点击事件
     *  @param confirmTitle 按钮名称
     *  @param confirmAction 确定点击事件
     */
    convenience public init(title aTitle: String?, message aMessage: String?, cancelTitle aCancelTitle: String, cancelAction cancel: ((alertAction: CMNAlertAction) -> Void)?, confirmTitle aConfirmTitle: String, confirmAction confirm: ((alertAction: CMNAlertAction) -> Void)?) {
        self.init(title: aTitle, message: aMessage, style: CMNAlertControllerStyle.Alert);
    
        self.addAction(CMNAlertAction(title: aCancelTitle, style: CMNAlertActionStyle.Cancel, action: cancel));
        self.addAction(CMNAlertAction(title: aConfirmTitle, style: CMNAlertActionStyle.Default, action: confirm));
    }
    
    /**
     *  添加按钮
     *
     *  @param action
     */
    public func addAction(action: CMNAlertAction) {
        self.actions.append(action);
        
        if (UIDevice.cmn_isVersion8OrAbove()) {
            let alertAction: UIAlertAction = UIAlertAction(title: action.title, style: action.style.convert(), handler: { (alertAction: UIAlertAction) -> Void in
                action.performAction();
            });
            
            let alertViewController: UIAlertController? = self.adaptiveAlert as? UIAlertController;
            alertViewController?.addAction(alertAction);
        } else {
            if (self.style == CMNAlertControllerStyle.Alert) {
                let alertView: UIAlertView? = self.adaptiveAlert as? UIAlertView;
                let currentButtonIndex: NSInteger? = alertView?.addButtonWithTitle(action.title);
                
                if (action.style == CMNAlertActionStyle.Cancel) {
                    alertView?.cancelButtonIndex = currentButtonIndex!;
                }
            } else {
                let actionSheet: UIActionSheet? = self.adaptiveAlert as? UIActionSheet;
                let currentButtonIndex: NSInteger? = actionSheet?.addButtonWithTitle(action.title);
                
                if (action.style == CMNAlertActionStyle.Cancel) {
                    actionSheet?.cancelButtonIndex = currentButtonIndex!;
                } else if (action.style == CMNAlertActionStyle.Destructive) {
                    actionSheet?.destructiveButtonIndex = currentButtonIndex!;
                }
            }
        }
    }
    
    /**
     *  显示
     *
     *  @param animated 是否动画
     */
    public func present(animated flag: Bool) {
        self.present(fromViewController: nil, animated: flag);
    }

    /**
     *  显示
     * 
     *  @param fromViewController 指定viewController
     *  @param animated 是否动画
     */
    public func present(fromViewController viewController: UIViewController?, animated flag: Bool) {
        if (UIDevice.cmn_isVersion8OrAbove()) {
            let alertViewController: UIAlertController? = self.adaptiveAlert as? UIAlertController;
            
            if (alertViewController != nil) {
                
                var fromViewController: UIViewController? = viewController;
                if (fromViewController == nil) {
                    
                    if (UIApplication.sharedApplication().keyWindow == nil ||
                        UIApplication.sharedApplication().keyWindow!.rootViewController == nil) {
                        return;
                    }
                    
                    fromViewController = UIApplication.sharedApplication().keyWindow!.rootViewController;
                    
                    while ((fromViewController!.presentedViewController) != nil) {
                        fromViewController = fromViewController!.presentedViewController;
                    }
                    
                    if (fromViewController == nil) {
                        return;
                    }
                }
                
                fromViewController!.presentViewController(alertViewController!, animated: flag, completion: nil);
            }
        } else {
            self.alertViewController = self;
            
            if let alertView = self.adaptiveAlert as? UIAlertView {
                alertView.show();
            } else if let actionSheet = self.adaptiveAlert as? UIActionSheet {
                if(UIApplication.sharedApplication().keyWindow != nil) {
                    actionSheet.showInView(UIApplication.sharedApplication().keyWindow!);
                }
            }
        }
    }
    
    private func initAlert(title aTitle: String?, message aMessage: String?) {
        if (UIDevice.cmn_isVersion8OrAbove()) {
            self.adaptiveAlert = UIAlertController(title: aTitle, message: aMessage, preferredStyle: self.style.convert());
        } else {
            if (self.style == CMNAlertControllerStyle.ActionSheet) {
                self.adaptiveAlert = UIActionSheet(title: aTitle, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil);
            } else {
                self.adaptiveAlert = UIAlertView(title: aTitle, message: aMessage, delegate: self, cancelButtonTitle: nil);
            }
        }
    }
    
    public func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if (buttonIndex < self.actions.count) {
            self.actions[buttonIndex].performAction();
        }
    }
    
    public func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        self.alertViewController = nil;
    }
    
    public func actionSheetCancel(actionSheet: UIActionSheet) {
        self.alertViewController = nil;
    }
    
    public func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if (buttonIndex < self.actions.count) {
            self.actions[buttonIndex].performAction();
        }
    }
    
    public func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        self.alertViewController = nil;
    }
    
    public func alertViewCancel(alertView: UIAlertView) {
        self.alertViewController = nil;
    }
}
