//
//  PageViewController.swift
//  Shazam
//
//  Created by Alessio Di Matteo on 11/12/2019.
//  Copyright © 2019 Alessio Di Matteo. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    //statusBar hidden
     override var prefersStatusBarHidden: Bool {
         return true
     }
    lazy var orderedViewController : [UIViewController] = {
        return [self.newWc(viewController: "left"),
                self.newWc(viewController: "center"),
                self.newWc(viewController: "right")]
    }()
    
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.dataSource = self
        let firstViewController = orderedViewController[1]
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        
        self.delegate = self
        configurePageControl()

    }
    

    func newWc(viewController:String) ->UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewController.firstIndex(of: viewController) else {
            return nil
        }
    let previousIndex = viewControllerIndex - 1
    
    guard previousIndex >= 0 else{
    return nil
    }
        
        guard orderedViewController.count > previousIndex else{
            return nil
        }
        
        return orderedViewController[previousIndex]
}
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewController.firstIndex(of: viewController) else {
                return nil
            }
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewController.count != nextIndex else{
        return nil
        }
            
            guard orderedViewController.count > nextIndex else{
                return nil
            }
            
            return orderedViewController[nextIndex]
    }
    
        func configurePageControl(){
            pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxX, width: UIScreen.main.bounds.width, height: 50))
                   pageControl.numberOfPages = orderedViewController.count
                    pageControl.currentPage = 1
                   pageControl.tintColor = UIColor.lightGray
                   pageControl.pageIndicatorTintColor = UIColor.lightGray
                   pageControl.currentPageIndicatorTintColor = UIColor.white
                   pageControl.layer.position.y = self.view.frame.height - 818
                   self.view.addSubview(pageControl)
        }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewController.firstIndex(of: pageContentViewController)!
    }
}
