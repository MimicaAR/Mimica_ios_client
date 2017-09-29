//
//  TutorialPageViewController.swift
//  Mimica
//
//  Created by Gleb Linnik on 28.09.2017.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
	
	var pages = [UIViewController]()
	let pageControl = UIPageControl()
	let tutorials: [[String : Any]] = [[TutorialViewControllerImageKey : "Home icon",
	                  TutorialViewControllerTitleKey : "First",
	                  TutorialViewControllerDescriptionKey : "Fisrt View Description",
	                  TutorialViewControllerIsHasButtonKey : TutorialViewControllerIsHasButton.hidden],
	                 [TutorialViewControllerImageKey : #imageLiteral(resourceName: "Password icon"),
	                  TutorialViewControllerTitleKey : "Second",
	                  TutorialViewControllerDescriptionKey : "Second View Description",
	                  TutorialViewControllerIsHasButtonKey : TutorialViewControllerIsHasButton.hidden],
	                 [TutorialViewControllerImageKey : #imageLiteral(resourceName: "MimicaFull"),
	                  TutorialViewControllerTitleKey : "Last",
	                  TutorialViewControllerDescriptionKey : "Fisrt View Description",
	                  TutorialViewControllerIsHasButtonKey : TutorialViewControllerIsHasButton.shown]]
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .white
		
		dataSource = self
		delegate = self
		
		for tutorial in tutorials {
			let viewController = TutorialViewController()
			viewController.options = tutorial
			pages.append(viewController)
		}
		
		setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)
		
		pageControl.numberOfPages = pages.count
		pageControl.currentPageIndicatorTintColor = UIColor.black
		pageControl.pageIndicatorTintColor = UIColor.lightGray
		pageControl.currentPage = 0
		view.addSubview(pageControl)
		
		pageControl.autoPinEdges(toSuperviewMarginsExcludingEdge: .top)
    }
	
	//MARK: UIPageViewControllerDelegate
	
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		
		// set the pageControl.currentPage to the index of the current viewController in pages
		if let viewControllers = pageViewController.viewControllers {
			if let viewControllerIndex = pages.index(of: viewControllers[0]) {
				pageControl.currentPage = viewControllerIndex
			}
		}
	}
	
	//MARK: UIPageViewControllerDataSource
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		if let viewControllerIndex = self.pages.index(of: viewController) {
			if viewControllerIndex == 0 {
				return nil
			} else {
				return self.pages[viewControllerIndex - 1]
			}
		}
		return nil
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		if let viewControllerIndex = self.pages.index(of: viewController) {
			if viewControllerIndex < self.pages.count - 1 {
				return self.pages[viewControllerIndex + 1]
			} else {
				return nil
			}
		}
		return nil
	}
}
