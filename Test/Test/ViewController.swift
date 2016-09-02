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

//        self.rtm_eachProperty { (name, value, stop) -> Void in
//            NSLog("%@", name);
//        };
        
        let image: UIImage = UIImage.grh_image(withSize: CGSizeMake(100, 100), withImage: UIImage(imageLiteral: "pinzhi"), withBorder: 1, withBorderColor: UIColor.redColor(), withCornerRadius: 10);
        
        let view: UIImageView = UIImageView(image: image);
        view.frm_left = 100;
        view.frm_top = 100;
        self.view.addSubview(view);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

