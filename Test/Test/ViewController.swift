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
    
//    var alert: CMNAlertController?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        self.rtm_eachProperty { (name, value, stop) -> Void in
//            NSLog("%@", name);
//        };
        
//        let image: UIImage = UIImage(imageLiteral: "pinzhi").grh_image(withSize: CGSizeMake(100, 100), withBorder: 1, withBorderColor: UIColor.redColor(), withCornerRadius: 10);
//        
//        let view: UIImageView = UIImageView(image: image);
//        view.frm_left = 100;
//        view.frm_top = 100;
//        self.view.addSubview(view);


//        }

        
        //let button: UIButton = UIButton(type: UIButtonType.Custom);
        
        
        
        //button.backgroundColor = UIColor.cmn_color(hex: 0x000000, alpha: 0.5);
        
        //button.frame = CGRectMake(100, 100, 40, 35);
//        button.setTitle("fine", forState: UIControlState.Normal);
        //button.addTarget(self, action: Selector("touchedButton"), forControlEvents: UIControlEvents.TouchUpInside);
        //self.view.addSubview(button);
        
        //button.easy_selectedTitle = "fine";
        //NSLog("%@", button.easy_selectedTitle);
        
        self.blk_mainThreadSyncBlock {
            NSLog("%@", "i'm good");
        };
        
//        let right: Bool = 1.cmn_isIn([2, 3, 4]);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func touchedButton() {

//        alert = CMNAlertController(title: "联系", message: "支持iOS7哦～", style: CMNAlertControllerStyle.Alert);
//        
//        alert!.addAction(CMNAlertAction(title: "取消", style: CMNAlertActionStyle.Cancel, action: nil));
        
        var a: CMNAlertAction = CMNAlertAction(title: "", style: CMNAlertActionStyle.cancel, action: { (action) in
            
        });
        a.action1 = {(action) in
        
        };
    
       // var a: CMNAlertAction = CMNAlertAction(CMNAlertAction(title: "取消", style: CMNAlertActionStyle.cancel, action:nil));
       // a.action1
        
//        let alert: CMNAlertController = CMNAlertController(title: "联系", message: "支持iOS7哦～",
//            cancelAction: { (alertAction) -> Void in
//                    NSLog("%@", "cancel");
//                    }) { (alertAction) -> Void in
//                    NSLog("%@", "confirm");
//            };
//        alert.present(animated: true);
//    }
    }
}

