//
//  mioPageController.swift
//  Shazam
//
//  Created by Alessio Di Matteo on 12/12/2019.
//  Copyright © 2019 Alessio Di Matteo. All rights reserved.
//

import UIKit

class mioPageController: UIPageViewController, UIPageViewControllerDataSource {
    
    //sorgente
    var arrayPagina = ["left","center","right"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        assegno dataSource
        self.dataSource = self
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: arrayPagina[1])
        self.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
//        configurePageControl()

//        aspetto cerchi
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [type(of: self)])
//        let pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxX, width: UIScreen.main.bounds.width, height: 50))
        pageControl.backgroundColor = UIColor.blue
        pageControl.tintColor = UIColor.blue
        pageControl.pageIndicatorTintColor = UIColor.blue
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.layer.position.y = self.view.frame.height - 830

    }
    
    //indietro
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = self.arrayPagina.firstIndex(of: viewController.restorationIdentifier!) else {
            return nil
        }
        
        let nextIndex = currentIndex - 1
        guard nextIndex >= 0 else {
            return nil
        }
//        pageControl.currentPage = nextIndex
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: arrayPagina[nextIndex])
     }
     
    //avanti
     func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = self.arrayPagina.firstIndex(of: viewController.restorationIdentifier!) else {
            return nil
        }
        
        let nextIndex = currentIndex + 1
        
        guard nextIndex != arrayPagina.count else {
            return nil
        }
//        pageControl.currentPage = nextIndex
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: arrayPagina[nextIndex])
     }
    
//    metodo cerchi
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return arrayPagina.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 1
    }
    
//    func configurePageControl(){
//        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxX, width: UIScreen.main.bounds.width, height: 50))
//               pageControl.numberOfPages = arrayPagina.count
//                pageControl.currentPage = 1
//               pageControl.tintColor = UIColor.lightGray
//               pageControl.pageIndicatorTintColor = UIColor.lightGray
//               pageControl.currentPageIndicatorTintColor = UIColor.white
//               pageControl.layer.position.y = self.view.frame.height - 830
//               self.view.addSubview(pageControl)
//    }
}
