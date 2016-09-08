//
//  CMNAlertController.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/9/2.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public enum CMNAlertControllerStyle : Int {
    case actionSheet
    case alert

    func convert() -> UIAlertControllerStyle {
        switch self {
        case .actionSheet :
            return UIAlertControllerStyle.actionSheet;
        default :
            return UIAlertControllerStyle.alert;
        }
    }
}

public enum CMNAlertActionStyle : Int {
    case `default`
    case cancel
    case destructive
    
    func convert() -> UIAlertActionStyle {
        switch self {
        case .cancel :
            return UIAlertActionStyle.cancel;
        case .destructive :
            return UIAlertActionStyle.destructive;
        default :
            return UIAlertActionStyle.default;
        }
    }
}

/**
 *  AlertController的按钮元素
 *
 */
open class CMNAlertAction: NSObject {
    var title: String;
    var style: CMNAlertActionStyle;
    var action: ((_ alertAction: CMNAlertAction) -> Void)?;
    
    /**
     *  初始化（action通过addAction添加）
     *
     *  @param title 标题
     *  @param style 类型
     *  @param action 事件
     */
    public init(title aTitle: String, style aStyle: CMNAlertActionStyle, action aAction: ((_ alertAction: CMNAlertAction) -> Void)?) {
        self.title = aTitle;
        self.style = aStyle;
        self.action = aAction;
        
        super.init();
    }
    
    func performAction() {
        if(self.action != nil) {
            self.action!(self);
        }
        self.action = nil;
    }
}

/**
 *  支持iOS7的AlertController
 *
 */
open class CMNAlertController: NSObject, UIAlertViewDelegate, UIActionSheetDelegate {
    fileprivate var actions: [CMNAlertAction] = [];
    fileprivate var adaptiveAlert: AnyObject?;
    fileprivate var pStyle: CMNAlertControllerStyle;
    fileprivate var alertViewController: CMNAlertController?; // 自己引用自己，防止被释放， 主要用在iOS7.0的情况
    
    
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
    convenience public init(title aTitle: String?, message aMessage: String?, confirmTitle aConfirmTitle: String, confirmAction confirm: ((_ alertAction: CMNAlertAction) -> Void)?) {
        self.init(title: aTitle, message: aMessage, style: CMNAlertControllerStyle.alert);
        
        self.addAction(CMNAlertAction(title: aConfirmTitle, style: CMNAlertActionStyle.default, action: confirm));
    }

    /**
     *  初始化（Alert, 两个个按钮， 标题默认为取消、确定）
     *
     *  @param title 标题
     *  @param message 内容
     *  @param cancelAction 取消点击事件
     *  @param confirmAction 确定点击事件
     */
    convenience public init(title aTitle: String?, message aMessage: String?, cancelAction cancel: ((_ alertAction: CMNAlertAction) -> Void)?, confirmAction confirm: ((_ alertAction: CMNAlertAction) -> Void)?) {
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
    convenience public init(title aTitle: String?, message aMessage: String?, cancelTitle aCancelTitle: String, cancelAction cancel: ((_ alertAction: CMNAlertAction) -> Void)?, confirmTitle aConfirmTitle: String, confirmAction confirm: ((_ alertAction: CMNAlertAction) -> Void)?) {
        self.init(title: aTitle, message: aMessage, style: CMNAlertControllerStyle.alert);
    
        self.addAction(CMNAlertAction(title: aCancelTitle, style: CMNAlertActionStyle.cancel, action: cancel));
        self.addAction(CMNAlertAction(title: aConfirmTitle, style: CMNAlertActionStyle.default, action: confirm));
    }
    
    /**
     *  添加按钮
     *
     *  @param action
     */
    open func addAction(_ action: CMNAlertAction) {
        self.actions.append(action);
        
        if (UIDevice.cmn_isVersion8OrAbove()) {
            let alertAction: UIAlertAction = UIAlertAction(title: action.title, style: action.style.convert(), handler: { (alertAction: UIAlertAction) -> Void in
                action.performAction();
            });
            
            let alertViewController: UIAlertController? = self.adaptiveAlert as? UIAlertController;
            alertViewController?.addAction(alertAction);
        } else {
            if (self.style == CMNAlertControllerStyle.alert) {
                let alertView: UIAlertView? = self.adaptiveAlert as? UIAlertView;
                let currentButtonIndex: NSInteger? = alertView?.addButton(withTitle: action.title);
                
                if (action.style == CMNAlertActionStyle.cancel) {
                    alertView?.cancelButtonIndex = currentButtonIndex!;
                }
            } else {
                let actionSheet: UIActionSheet? = self.adaptiveAlert as? UIActionSheet;
                let currentButtonIndex: NSInteger? = actionSheet?.addButton(withTitle: action.title);
                
                if (action.style == CMNAlertActionStyle.cancel) {
                    actionSheet?.cancelButtonIndex = currentButtonIndex!;
                } else if (action.style == CMNAlertActionStyle.destructive) {
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
    open func present(animated flag: Bool) {
        self.present(fromViewController: nil, animated: flag);
    }

    /**
     *  显示
     * 
     *  @param fromViewController 指定viewController
     *  @param animated 是否动画
     */
    open func present(fromViewController viewController: UIViewController?, animated flag: Bool) {
        if (UIDevice.cmn_isVersion8OrAbove()) {
            let alertViewController: UIAlertController? = self.adaptiveAlert as? UIAlertController;
            
            if (alertViewController != nil) {
                
                var fromViewController: UIViewController? = viewController;
                if (fromViewController == nil) {
                    
                    if (UIApplication.shared.keyWindow == nil ||
                        UIApplication.shared.keyWindow!.rootViewController == nil) {
                        return;
                    }
                    
                    fromViewController = UIApplication.shared.keyWindow!.rootViewController;
                    
                    while ((fromViewController!.presentedViewController) != nil) {
                        fromViewController = fromViewController!.presentedViewController;
                    }
                    
                    if (fromViewController == nil) {
                        return;
                    }
                }
                
                fromViewController!.present(alertViewController!, animated: flag, completion: nil);
            }
        } else {
            self.alertViewController = self;
            
            if let alertView = self.adaptiveAlert as? UIAlertView {
                alertView.show();
            } else if let actionSheet = self.adaptiveAlert as? UIActionSheet {
                if(UIApplication.shared.keyWindow != nil) {
                    actionSheet.show(in: UIApplication.shared.keyWindow!);
                }
            }
        }
    }
    
    fileprivate func initAlert(title aTitle: String?, message aMessage: String?) {
        if (UIDevice.cmn_isVersion8OrAbove()) {
            self.adaptiveAlert = UIAlertController(title: aTitle, message: aMessage, preferredStyle: self.style.convert());
        } else {
            if (self.style == CMNAlertControllerStyle.actionSheet) {
                self.adaptiveAlert = UIActionSheet(title: aTitle, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil);
            } else {
                self.adaptiveAlert = UIAlertView(title: aTitle, message: aMessage, delegate: self, cancelButtonTitle: nil);
            }
        }
    }
    
    open func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        if (buttonIndex < self.actions.count) {
            self.actions[buttonIndex].performAction();
        }
    }
    
    open func actionSheet(_ actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        self.alertViewController = nil;
    }
    
    open func actionSheetCancel(_ actionSheet: UIActionSheet) {
        self.alertViewController = nil;
    }
    
    open func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if (buttonIndex < self.actions.count) {
            self.actions[buttonIndex].performAction();
        }
    }
    
    open func alertView(_ alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        self.alertViewController = nil;
    }
    
    open func alertViewCancel(_ alertView: UIAlertView) {
        self.alertViewController = nil;
    }
}
