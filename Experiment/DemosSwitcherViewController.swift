//
//  DemosSwitcherViewController.swift
//  Created by Guillaume Maiano on 24/11/16.
//

import UIKit

open class DemosSwitcherViewController: UIPageViewController, UIPageViewControllerDelegate {
    
    
    private class DemosSwitcherManager: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
        var pages = [UIViewController]()
        var storyboard: UIStoryboard? {
            didSet {
                guard (storyboard !=  nil) else
                {
                    return
                }
                let page1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "profileTests")
                let page2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "operationsTests")
                
                pages.append(page1)
                pages.append(page2)
                
            }
        }
        
        func presentationCount(for pageViewController: UIPageViewController) -> Int {
            return pages.count
        }
        
        func presentationIndex(for pageViewController: UIPageViewController) -> Int {
            return 0
        }
        
        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
            let currentIndex = pages.index(of: viewController)!
            let previousIndex = abs((currentIndex - 1) % pages.count)
            guard previousIndex < currentIndex else {
                
                return nil
                
            }
            return pages[previousIndex]
        }
        
        
        
        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
            let currentIndex = pages.index(of: viewController)!
            let nextIndex = abs((currentIndex + 1) % pages.count)
            
            guard nextIndex > currentIndex else {
                return nil
                
            }
            return pages[nextIndex]
        }
        
        func getInitialPagesToDisplay() -> [UIViewController]
        {
            return [pages[1]];
        }
    }
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let demoManager: DemosSwitcherManager = DemosSwitcherManager()
        demoManager.storyboard = self.storyboard
        
        self.delegate = demoManager
        self.dataSource = demoManager
        
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.backgroundColor = UIColor.black
        
        setViewControllers(demoManager.getInitialPagesToDisplay(), direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        didMove(toParentViewController: self)
        
    }
    
}
