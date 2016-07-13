//
//  ViewController.swift
//  ActionLabel
//
//  Created by mac on 16/7/8.
//  Copyright © 2016年 Gaol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testLabel = ActionShowLabel(frame:CGRectMake(50,100,180,21))
        testLabel.speed = 0.6
        self.view.addSubview(testLabel)
        
        testLabel.text = "如果觉得我的文章对您有用，请随意打赏。您的支持将鼓励我继续创作！"
        testLabel.textColor = UIColor.yellowColor()
        testLabel.font = UIFont.systemFontOfSize(23)
        testLabel.backgroundColor = UIColor.grayColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

