//
//  NSObject+RunTime.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/8/4.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

/*!
*  @brief  替换方法，添加属性
*/
public extension NSObject {
    
    /*!
    *  @brief  替换方法
    *
    *  @param oSelector 老方法
    *  @param newSelector 新方法
    */
    static func rtm_swizzleMethod(oSelector: Selector, newSelector nSelector: Selector) {
        let cls : AnyClass = self.classForCoder();
        let oMethod : Method = class_getInstanceMethod(cls, oSelector);
        let nMethod : Method = class_getInstanceMethod(cls, nSelector);
        
        let didAddMethod : Bool = class_addMethod(cls, oSelector, method_getImplementation(nMethod), method_getTypeEncoding(nMethod));
        
        if (didAddMethod) {
            class_replaceMethod(cls, nSelector, method_getImplementation(oMethod), method_getTypeEncoding(oMethod));
        } else {
            method_exchangeImplementations(oMethod, nMethod);
        }
    }
    
    /*!
    *  @brief  关联策略：strong, nonatomic
    *
    *  @param object 被关联对象
    *  @param key   key
    */
    func rtm_associateStrongNonatomicObject(obj:AnyObject!, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    
    
}
