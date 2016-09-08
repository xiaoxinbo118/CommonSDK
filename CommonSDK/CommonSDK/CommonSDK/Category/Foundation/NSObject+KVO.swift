//
//  NSObject+KVO.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/8/9.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

private class CMNSafeKVO : NSObject {
    var keyPath: String?;
    weak var observer: NSObject?;
    var unsafe: AnyObject?;//用于记录监听对象的指针地址，因为移除对象需要指针地址
    var block : ((String?, AnyObject?, [NSKeyValueChangeKey : Any]?, UnsafeMutableRawPointer?) -> Void)?;

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if(self.observer != nil && self.observer!.isEqual(object)) {
            return;
        }
        
        if(self.block != nil) {
            self.block!(keyPath, object as AnyObject?, change, context);
        } else if (self.observer != nil) {
            self.observer!.observeValue(forKeyPath: keyPath, of: object, change: change, context: context);
        } else {
            self.clear();
        }
    }

    func clear() {
        if(self.unsafe != nil && !String.vld_isBlank(self.keyPath)) {
            self.unsafe!.removeObserver(self, forKeyPath: self.keyPath!);
        }
        
        self.unsafe = nil;
        self.block = nil;
    }
    
    deinit {
        self.clear();
    }
}

public extension NSObject {
    
    /**
     @brief observer管理器
     */
    fileprivate var kvo_observer_manager: Array<CMNSafeKVO> {
        get {
            let obj = self.rtm_associatedObjectForKey("kvo_observer_manager");
            var array: Array<CMNSafeKVO>;
            
            if (obj == nil) {
                objc_sync_enter(self);
                array = Array<CMNSafeKVO>();
                self.rtm_associateStrongAtomicObject(array as Any, key: "kvo_observer_manager");
                objc_sync_exit(self);
            } else {
                array = obj as! Array<CMNSafeKVO>;
            }
            
            return array;
        }
        set(newValue) {
            objc_sync_enter(self);
            self.rtm_associateStrongAtomicObject(newValue, key: "kvo_observer_manager");
            objc_sync_exit(self);
        }
    }
    
    //添加监听者
    fileprivate func kvo_setObserver(_ kvo: CMNSafeKVO) {
        if(kvo.observer == nil) {
            return;
        }

        objc_sync_enter(self);
        var index: NSInteger = 0;
        for item: CMNSafeKVO in self.kvo_observer_manager {
            if(item.observer == kvo.observer && item.keyPath == kvo.keyPath) {
                self.kvo_observer_manager.remove(at: index);
                break;
            }
            index += 1;
        }

        self.kvo_observer_manager.append(kvo);
        objc_sync_enter(self);
    }
    
    /**
    *  安全的添加kvo，若当前对象的keyPath值有对应的变化，将会回调
    *  observer的-observeValueForKeyPath:ofObject:change:context:方法
    *
    *  @param observer 注册者（观察者，监听者）
    *  @param keyPath  属性路径
    *  @param options  变化
    *  @param context  其他参数
    */
    public func kvo_addObserver(_ observer: NSObject, keyPath: String, options: NSKeyValueObservingOptions, context: UnsafeMutableRawPointer?) {
        let safeKVO: CMNSafeKVO = CMNSafeKVO();
        safeKVO.keyPath = keyPath;
        safeKVO.observer = observer;
        safeKVO.block = nil;
        safeKVO.unsafe = self;
        
        self.kvo_setObserver(safeKVO)
        self.addObserver(safeKVO, forKeyPath:keyPath, options: options, context:context);
//   self.kvo_addObserver(observer, keyPath: keyPath, options: options, context: nil);
    }
    
    /**
     *  安全的添加kvo，若当前对象的keyPath值有对应的变化，将会回调callback，无法移除block
     *
     *  @param keyPath  属性路径
     *  @param options  变化
     *  @param context  其他参数
     *  @param callback 监听回调，请确保不要循环引用（⭐️重要）
     */
    public func kvo_addObserver(_ observer: NSObject, keyPath: String, options: NSKeyValueObservingOptions, context: UnsafeMutableRawPointer?, callback:@escaping ((String?, AnyObject?, [NSKeyValueChangeKey : Any]?, UnsafeMutableRawPointer?) -> Void)) {
        let safeKVO: CMNSafeKVO = CMNSafeKVO();
        safeKVO.keyPath = keyPath;
        safeKVO.observer = observer;
        safeKVO.block = callback;
        safeKVO.unsafe = self;
        
        self.kvo_setObserver(safeKVO)
        self.addObserver(safeKVO, forKeyPath:keyPath, options: options, context:context);
    }
    
    /**
    *  移除监听者
    *
    *  @param observer 注册者（观察者，监听者）
    *  @param keyPath  属性路径，若传入keyPath为空，则清空所有
    */
    public func kvo_removeObserver(_ observer: NSObject, keyPath: String) {
        var index: NSInteger = 0;

        for item: CMNSafeKVO in self.kvo_observer_manager {
            if(item.observer == observer && item.keyPath == keyPath) {
                objc_sync_enter(self);
                self.kvo_observer_manager.remove(at: index);
                objc_sync_exit(self);
                break;
            }
            index += 1;
        }
    }
    
    /**
     *  移除监听者
     *
     *  @param observer 注册者（观察者，监听者）
     *  @param keyPath  属性路径，若传入keyPath为空，则清空所有
     */
    public func kvo_removeObserver(_ observer: NSObject) {
        var index: NSInteger = 0;

        let newArray: Array<CMNSafeKVO> = Array<CMNSafeKVO>(self.kvo_observer_manager);
        for item: CMNSafeKVO in newArray {
            if(item.observer == observer) {
                objc_sync_enter(self);
                self.kvo_observer_manager.remove(at: index);
                objc_sync_exit(self);
                break;
            }
            index += 1;
        }
    }
    
    /**
    *  移除所有监听者
    */
    public func kvo_removeAllObservers() {
        objc_sync_enter(self);
        self.kvo_observer_manager.removeAll();
        objc_sync_exit(self);
    }
}
