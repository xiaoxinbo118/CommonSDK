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
    public class func rtm_swizzleMethod(_ oSelector: Selector, newSelector nSelector: Selector) {
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
    public func rtm_associateStrongNonatomicObject(_ obj:Any?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    public class func rtm_associateStrongNonatomicObject(_ obj:Any?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    /*!
    *  @brief  关联策略：strong, atomic
    *
    *  @param object 被关联对象
    *  @param key   key
    */
    public func rtm_associateStrongAtomicObject(_ obj:Any?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    public class func rtm_associateStrongAtomicObject(_ obj:Any?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    
    /*!
    *  @brief  关联策略：copy, nonatomic
    *
    *  @param object 被关联对象
    *  @param key   key
    */
    public func rtm_associateCopyNonatomicObject(_ obj:Any?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    public class func rtm_associateCopyNonatomicObject(_ obj:Any?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
    }

    /*!
    *  @brief  关联策略：copy, atomic
    *
    *  @param object 被关联对象
    *  @param key   key
    */
    public func rtm_associateCopyAtomicObject(_ obj:Any?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
    }
    public class func rtm_associateCopyAtomicObject(_ obj:AnyObject?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
    }
    
    /*!
    *  @brief  关联策略：weak
    *
    *  @param object 被关联对象
    *  @param key   key
    */
    public func rtm_associateWeakAtomicObject(_ obj:Any?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }
    public class func rtm_associateWeakAtomicObject(_ obj:Any?, key aKey:String!) {
        objc_setAssociatedObject(self, aKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }
    
    /*!
    *  @brief  获取关联对象
    *
    *  @param key keu
    *
    *  @return 被关联对象的value
    */
    public func rtm_associatedObjectForKey(_ key:String) -> AnyObject? {
        return objc_getAssociatedObject(self, key) as AnyObject?;
    }
    public class func rtm_associatedObjectForKey(_ key:String) -> AnyObject? {
        return objc_getAssociatedObject(self, key) as AnyObject?;
    }
    
    /*!
    *  @brief  移除所有关联对象
    */
    public func rtm_removeAllAssociatedObjects() {
        objc_removeAssociatedObjects(self);
    }
    public class func rtm_removeAllAssociatedObjects() {
        objc_removeAssociatedObjects(self);
    }
    
    /*!
    *  toodo 是否只读
    *  @brief  获得所有的属性
    */
    public func rtm_eachProperty(_ block: ((_ name: String, _ value: Any?, _ readyOnly: Bool, _ stop: inout Bool) -> Void)) {
        
        let countPoint: UnsafeMutablePointer<UInt32> = UnsafeMutablePointer<UInt32>.allocate(capacity: 1);
        let properties: UnsafeMutablePointer<objc_property_t?> = class_copyPropertyList(self.classForCoder, countPoint);
        
        let count: Int = Int(countPoint.pointee);
        
        countPoint.deinitialize();
        countPoint.deallocate(capacity: 1);
        
        var stop: Bool = false;
        
        for x in 0 ..< count {
            let property = properties[x];
            let name: String! = String(cString: property_getName(property));
//            let attr: String! = String.fromCString(property_getAttributes(property));
            
            var value: AnyObject?;
            if(self.responds(to: Selector(name))) {
                value = self.value(forKey: name) as AnyObject?;
            }
            
            block(name, value, false, &stop);
            
            if(stop == true) {
                break;
            }
        }
        
        free(properties);
    }
}
