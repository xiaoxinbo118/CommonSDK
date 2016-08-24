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
    func rtm_associateStrongNonatomicObject(obj:AnyObject?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    static func rtm_associateStrongNonatomicObject(obj:AnyObject?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    /*!
    *  @brief  关联策略：strong, atomic
    *
    *  @param object 被关联对象
    *  @param key   key
    */
    func rtm_associateStrongAtomicObject(obj:AnyObject?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    static func rtm_associateStrongAtomicObject(obj:AnyObject?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    
    /*!
    *  @brief  关联策略：copy, nonatomic
    *
    *  @param object 被关联对象
    *  @param key   key
    */
    func rtm_associateCopyNonatomicObject(obj:AnyObject?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    static func rtm_associateCopyNonatomicObject(obj:AnyObject?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
    }

    /*!
    *  @brief  关联策略：copy, atomic
    *
    *  @param object 被关联对象
    *  @param key   key
    */
    func rtm_associateCopyAtomicObject(obj:AnyObject?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
    }
    static func rtm_associateCopyAtomicObject(obj:AnyObject?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
    }
    
    /*!
    *  @brief  关联策略：weak
    *
    *  @param object 被关联对象
    *  @param key   key
    */
    func rtm_associateWeakAtomicObject(obj:AnyObject?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }
    static func rtm_associateWeakAtomicObject(obj:AnyObject?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }
    
    /*!
    *  @brief  获取关联对象
    *
    *  @param key keu
    *
    *  @return 被关联对象的value
    */
    func rtm_associatedObjectForKey(key:String) -> AnyObject? {
        return objc_getAssociatedObject(self, key);
    }
    static func rtm_associatedObjectForKey(key:String) -> AnyObject? {
        return objc_getAssociatedObject(self, key);
    }
    
    /*!
    *  @brief  移除所有关联对象
    */
    func rtm_removeAllAssociatedObjects() {
        objc_removeAssociatedObjects(self);
    }
    static func rtm_removeAllAssociatedObjects() {
        objc_removeAssociatedObjects(self);
    }
    
    /*!
    *  toodo 是否只读
    *  @brief  获得所有的属性
    */
    func rtm_eachProperty(block: ((name: String, value: AnyObject?, inout stop: Bool) -> Void)) {
        
        let countPoint: UnsafeMutablePointer<UInt32> = UnsafeMutablePointer<UInt32>.alloc(1);
        let properties: UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(self.classForCoder, countPoint);
        
        let count: Int = Int(countPoint.memory);
        
        countPoint.destroy();
        countPoint.dealloc(1);
        
        var stop: Bool = false;
        
        for(var x: Int = 0; x < count; x++) {
            let property = properties[x];
            let name: String! = String.fromCString(property_getName(property));
            
            var value: AnyObject?;
            if(self.respondsToSelector(Selector(name))) {
                value = self.valueForKey(name);
            }
            
            block(name: name, value: value, stop: &stop);
            
            if(stop == true) {
                break;
            }
        }
        
        free(properties);
    }
}
