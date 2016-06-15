//
//  ViewsController.swift
//  UIPageViewController_UISegment
//
//  Created by yaosixu on 16/6/14.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ViewsController : SegmentViewController {
 
    override func viewDidLoad() {
        print("viewsViewController: \(#function)")
        super.viewDidLoad()
        let vcOne = ViewOneController()
        let vcTwo = ViewTwoController()
        
        vcOne.segmentTitle = "One"
        vcTwo.segmentTitle = "Two"
        
        myViewControllers = [vcOne,vcTwo]
        print("viewsViewController: \(#function) end")
    }
    
}