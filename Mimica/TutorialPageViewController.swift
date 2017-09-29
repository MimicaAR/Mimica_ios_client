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
	var tutorials: NSArray? = nil
	
	let nextButton: UIButton = {
		let button = UIButton()
		button.setTitleColor(SharedStyleKit.mainGradientColor1, for: .normal)
		button.setTitle("Next➜", for: .normal)
		button.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 16.0)
		return button
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		dataSource = self
		delegate = self
		loadTutorials()
		setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)
		configureAutolayout()
		
		view.addSubview(nextButton)
		nextButton.autoPinEdge(toSuperviewMargin: .right)
		nextButton.autoPinEdge(toSuperviewMargin: .bottom)
    }
	
	fileprivate func loadTutorials() {
		if let path = Bundle.main.path(forResource: "Tutorials", ofType: "plist") {
			tutorials = NSArray(contentsOfFile: path)
		}
		
		if let tutorials = tutorials {
			for tutorial in tutorials {
				let viewController = TutorialViewController()
				viewController.options = tutorial as? [String : Any]
				pages.append(viewController)
			}
		}
	}
	
	fileprivate func configureAutolayout() {
		view.backgroundColor = .white
		
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
