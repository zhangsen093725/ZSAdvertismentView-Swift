//
//  ViewController.swift
//  ZSAdvertismentScroll
//
//  Created by 张森 on 15/11/30.
//  Copyright © 2015年 张森. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let advertisment:ZSAdvertismentView = ZSAdvertismentView.init(frame: CGRectMake(0, 0, 100, 100))
        advertisment.height = 300;
        advertisment.imagesName = ["1","2","3"]
        advertisment.touchBlock = {
            (selectIndex:NSInteger) -> Void in print(selectIndex)
        }
        self.view.addSubview(advertisment)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

