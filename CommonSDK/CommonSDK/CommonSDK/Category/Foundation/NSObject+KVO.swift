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
    weak var object: AnyObject?;
    var block : ((String?, AnyObject?, [String : AnyObject]?, UnsafeMutablePointer<Void>) -> Void)?;

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
    }
}

public extension NSObject {
    
}
