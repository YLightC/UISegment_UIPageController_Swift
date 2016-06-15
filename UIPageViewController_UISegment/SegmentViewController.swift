//
//  SegmentViewController.swift
//  UIPageViewController_UISegment
//
//  Created by yaosixu on 16/6/14.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class SegmentViewController: UIPageViewController {
    
    var myViewControllers : [UIViewController] = [] {
        didSet {
            initialize()
        }
    }
    var segmentController = UISegmentedControl()
    
    
    override func viewDidLoad() {
        print("SegmentViewController :: \(#function)")
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        self.dataSource = self
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initialize() {
        myViewControllers.enumerate().forEach {
            $1.pageIndex = $0
            $1.view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        }
        let items = myViewControllers.flatMap {
            return $0.segmentTitle
        }
        self.setViewControllers([myViewControllers[0]], direction: .Forward, animated: true) { _ in }
        segmentController = UISegmentedControl(items: items)
        for (index,_) in items.enumerate() {
            segmentController.setWidth(80, forSegmentAtIndex: index)
        }
        segmentController.addTarget(self, action: #selector(changeSegmentIndex), forControlEvents: .ValueChanged)
        segmentController.selectedSegmentIndex = 0
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        self.navigationItem.titleView = segmentController
    }
    
    func changeSegmentIndex(segment:UISegmentedControl) {
        
        if segment.selectedSegmentIndex == 0 {
            self.setViewControllers([myViewControllers[0]], direction: .Reverse, animated: false, completion: nil)
        } else {
            self.setViewControllers([myViewControllers[1]], direction: .Forward, animated: false, completion: nil)
        }
        
    }
    
}

extension SegmentViewController : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //Mark DataSource
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        guard let index = myViewControllers.indexOf(viewController) else {
            return nil
        }
        
        if index - 1 < 0 {
            return nil
        }
        
        return self.myViewControllers[index - 1]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let index = myViewControllers.indexOf(viewController) else {
            return nil
        }
        
        if index + 1 == self.myViewControllers.count {
            return nil
        }
        
        return self.myViewControllers[index + 1]
    }
    
    
    //Mark Delegate
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        
        guard let vc = pendingViewControllers.first , let index = myViewControllers.indexOf(vc) else {
            return
        }
        
        segmentController.selectedSegmentIndex = index
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
}

extension UIViewController {
    private struct AssociatedKeys {
        static var segmentTitleKey   = "segmentTitle"
        static var pageIndexKey   = "pageIndex"
    }
    
    var segmentTitle : AnyObject {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.segmentTitleKey)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.segmentTitleKey, (newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var pageIndex : Int {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.pageIndexKey) as? Int ?? 0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.pageIndexKey, (newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


