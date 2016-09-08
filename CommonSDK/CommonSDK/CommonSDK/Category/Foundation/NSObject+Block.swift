//
//  NSObject+Block.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/8/2.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

/**
 *  主要替换如下过程：
 dispatch_async(dispatch_get_main_queue(), ^{
 //todo
 });
 
 这种方式在某种情况下存在风险，如果一个底层系统回调到主线程时，千万不要随意使用上面的方式
 这是一种不可预测的写法，可能造成main_queue阻断，如果block中又嵌套的runloop，
 将造成后续的block无法执行
 */

public class CancelableBlock : NSObject {
    weak var target : NSObject?;
    var block : ()->() = {};
    
    public override init() {
        super.init();
    }
    
    func cancel() {
        if(self.target != nil) {
            NSObject.cancelPreviousPerformRequests(withTarget: self.target!, selector: #selector(NSObject.blk_excute(block:)), object: self)
        }
    }
}
public extension NSObject {
    
    
    
    @objc public func blk_excute(block aBlock:CancelableBlock) {
        aBlock.block();
    }
    
    @objc public class func blk_excute(block aBlock:CancelableBlock) {
        aBlock.block();
    }
    
    /**
    *  到主线程中同步执行block
    *
    *  @param block 执行的block
    */
    public func blk_mainThreadSyncBlock(_ block:@escaping ()->()) {
        let obj : CancelableBlock = CancelableBlock();
        obj.target = self;
        obj.block = block;
        self.performSelector(onMainThread: #selector(NSObject.blk_excute(block:)), with:obj, waitUntilDone:true);
    }
    
    /**
    *  到主线程中异步执行block
    *
    *  @param block 执行的block
    */
    public func blk_mainThreadAsyncBlock(_ block:@escaping ()->()) {
        let obj : CancelableBlock = CancelableBlock();
        obj.target = self;
        obj.block = block;
        self.performSelector(onMainThread: #selector(NSObject.blk_excute(block:)), with:obj, waitUntilDone:false);
    }

    /**
    *  到主线程中延迟执行block
    *
    *  @param block 执行的block
    */
    public func blk_mainThreadAfter(_ after:TimeInterval, block aBlock:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64((after * TimeInterval(NSEC_PER_SEC)))) / Double(NSEC_PER_SEC), execute: aBlock);
    }

    /**
    *  到主线程中同步执行block
    *
    *  @param block 执行的block
    */
    public class func blk_mainThreadSyncBlock(_ block:@escaping ()->()) {
        let obj : CancelableBlock = CancelableBlock();
        obj.block = block;
        self.performSelector(onMainThread: #selector(NSObject.blk_excute(block:)), with:obj, waitUntilDone:true);
    }
    
    /**
     *  到主线程中异步执行block
     *
     *  @param block 执行的block
     */
    public class func blk_mainThreadAsyncBlock(_ block:@escaping ()->()) {
        let obj : CancelableBlock = CancelableBlock();
        obj.block = block;
        self.performSelector(onMainThread: #selector(NSObject.blk_excute(block:)), with:obj, waitUntilDone:false);
    }

    /**
    *  到主线程中延迟执行block
    *
    *  @param block 执行的block
    */
    public class func blk_mainThreadAfter(_ after:TimeInterval, block aBlock:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64((after * TimeInterval(NSEC_PER_SEC)))) / Double(NSEC_PER_SEC), execute: aBlock);
    }
}
