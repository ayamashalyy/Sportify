//
//  ContainerPageViewController.swift
//  Sportify
//
//  Created by aya on 16/05/2024.
//

import UIKit

class ContainerPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    let onboardingImages = ["1", "6", "7"]

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
               delegate = self
               
               if let initialViewController = contentViewController(at: 0) {
                   setViewControllers([initialViewController], direction: .forward, animated: true, completion: nil)
               }

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
           guard let index = (viewController as? OnBoradingViewController)?.pageIndex else { return nil }
           let previousIndex = index - 1
           guard previousIndex >= 0 else { return nil }
           return contentViewController(at: previousIndex)
       }
       
       func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
           guard let index = (viewController as? OnBoradingViewController)?.pageIndex else { return nil }
           let nextIndex = index + 1
           guard nextIndex < onboardingImages.count else {
               transitionToSplashScreen()
               return nil
               
           }
           return contentViewController(at: nextIndex)
       }
       
     
       
       func contentViewController(at index: Int) -> OnBoradingViewController? {
           guard index >= 0 && index < onboardingImages.count else { return nil }
           let contentViewController = storyboard?.instantiateViewController(withIdentifier: "page1") as? OnBoradingViewController
           contentViewController?.pageIndex = index
           contentViewController?.imageFileName = onboardingImages[index]
           return contentViewController
       }
    
      func transitionToSplashScreen() {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let vc = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as! ViewController
           vc.modalPresentationStyle = .fullScreen
           vc.modalTransitionStyle = .crossDissolve
           self.present(vc, animated: true)
       }
  

}
