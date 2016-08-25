//
//  ViewController.swift
//  Test
//
//  Created by 肖信波 on 16/7/22.
//  Copyright © 2016年 fengqu. All rights reserved.
//

import UIKit
import CommonSDK

class ViewController: UIViewController {

    var name: String {
        get {
            return "name";
        }
        set(value) {
        
        }
    }
    
    var age: Int {
        get {
            return 1;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.rtm_eachProperty { (name, value, stop) -> Void in
            NSLog("%@", name);
        };
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

