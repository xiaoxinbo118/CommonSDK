//
//  Common.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/9/5.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public extension Equatable {
    
    /*!
    *  @brief 包含在某个集合中
    *
    */
    public func cmn_isIn(_ collection: Array<Self>) -> Bool {
        return collection.contains(self);
    }

    /*!
    *  @brief 包含在某个集合中
    *
    */
    public func cmn_isIn(_ collection: Self...) -> Bool {
        return collection.contains(self);
    }
}
