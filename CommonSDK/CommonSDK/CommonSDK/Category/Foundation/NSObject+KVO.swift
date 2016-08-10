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
    weak var observer: AnyObject?;
    var unsafe: AnyObject?;//用于记录监听对象的指针地址，因为移除对象需要指针地址
    var block : ((String?, AnyObject?, [String : AnyObject]?, UnsafeMutablePointer<Void>) -> Void)?;

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if(self.block != nil) {
            self.block!(keyPath, object, change, context);
        } else if (self.observer != nil) {
            self.observer!.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context);
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
    
    
    
    func kvo_addObserve(observer: AnyObject, keyPath: String, options: NSKeyValueObservingOptions, context: UnsafeMutablePointer<Void>, callback:((String?, AnyObject?, [String : AnyObject]?, UnsafeMutablePointer<Void>) -> Void)) {
        let safeKVO: CMNSafeKVO = CMNSafeKVO();
        safeKVO.keyPath = keyPath;
        safeKVO.observer = observer;
        safeKVO.block = callback;
        safeKVO.unsafe = self;
        
        self.addObserver(safeKVO, forKeyPath:keyPath, options: options, context:context);
    }
}
