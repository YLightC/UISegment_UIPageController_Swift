//
//  ViewController.swift
//  UIPageViewController_UISegment
//
//  Created by yaosixu on 16/6/14.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let jumpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        automaticallyAdjustsScrollViewInsets = false
        jumpButton.setTitle("Jump", forState: .Normal)
        jumpButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        jumpButton.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        jumpButton.backgroundColor = UIColor.cyanColor()
        
        view.addSubview(jumpButton)
        jumpButton.addTarget(self, action: #selector(ViewController.tapJumpButton), forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tapJumpButton() {
        self.navigationController?.pushViewController(ViewsController(), animated: true)
    }

}

