//
//  NSObject+Block.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/8/2.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public class CancelableBlock : NSObject {
    weak var target : NSObject?;
    var block : dispatch_block_t?;

    func cancel() {
        if(self.target != nil) {
            NSObject.cancelPreviousPerformRequestsWithTarget(self.target!, selector: Selector("blk_excuteBlock:"), object: self)
        }
    }
}

/**
 *  主要替换如下过程：
 dispatch_async(dispatch_get_main_queue(), ^{
 //todo
 });
 
 这种方式在某种情况下存在风险，如果一个底层系统回调到主线程时，千万不要随意使用上面的方式
 这是一种不可预测的写法，可能造成main_queue阻断，如果block中又嵌套的runloop，
 将造成后续的block无法执行
 */
public extension NSObject {

    public func blk_excuteBlock(block:CancelableBlock) {
        if((block.block) != nil) {
            block.block!();
        }
    }
    
    static public func blk_excuteBlock(block:CancelableBlock) {
        if((block.block) != nil) {
            block.block!();
        }
    }
    
    /**
    *  到主线程中同步执行block
    *
    *  @param block 执行的block
    */
    func blk_mainThreadSyncBlock(block:dispatch_block_t) {
        let obj : CancelableBlock = CancelableBlock();
        obj.target = self;
        obj.block = block;
        self.performSelectorOnMainThread(Selector("blk_excuteBlock:"), withObject:obj, waitUntilDone:true);
    }
    
    /**
    *  到主线程中异步执行block
    *
    *  @param block 执行的block
    */
    func blk_mainThreadAsyncBlock(block:dispatch_block_t) {
        let obj : CancelableBlock = CancelableBlock();
        obj.target = self;
        obj.block = block;
        self.performSelectorOnMainThread(Selector("blk_excuteBlock:"), withObject:obj, waitUntilDone:false);
    }

    /**
    *  到主线程中延迟执行block
    *
    *  @param block 执行的block
    */
    func blk_mainThreadAfter(after:NSTimeInterval, block aBlock:dispatch_block_t) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  Int64((after * NSTimeInterval(NSEC_PER_SEC)))), dispatch_get_main_queue(), aBlock);
    }

    /**
    *  到主线程中同步执行block
    *
    *  @param block 执行的block
    */
    static func blk_mainThreadSyncBlock(block:dispatch_block_t) {
        let obj : CancelableBlock = CancelableBlock();
        obj.block = block;
        self.performSelectorOnMainThread(Selector("blk_excuteBlock:"), withObject:obj, waitUntilDone:true);
    }
    
    /**
     *  到主线程中异步执行block
     *
     *  @param block 执行的block
     */
    static func blk_mainThreadAsyncBlock(block:dispatch_block_t) {
        let obj : CancelableBlock = CancelableBlock();
        obj.block = block;
        self.performSelectorOnMainThread(Selector("blk_excuteBlock:"), withObject:obj, waitUntilDone:false);
    }

    /**
    *  到主线程中延迟执行block
    *
    *  @param block 执行的block
    */
    static func blk_mainThreadAfter(after:NSTimeInterval, block aBlock:dispatch_block_t) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  Int64((after * NSTimeInterval(NSEC_PER_SEC)))), dispatch_get_main_queue(), aBlock);
    }
}
