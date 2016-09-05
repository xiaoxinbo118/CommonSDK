//
//  Common.swift
//  CommonSDK
//
//  Created by 肖信波 on 16/9/5.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit

public extension Equatable {
    
    func cmn_isIn(collection: Array<Self>) -> Bool {
        return collection.contains(self);
    }
    
    func cmn_isIn(collection: Self...) -> Bool {
        return collection.contains(self);
    }
}
