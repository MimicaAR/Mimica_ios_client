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
	
//	let nextButton: UIButton = {
//		let button = UIButton()
//		button.setTitleColor(SharedStyleKit.mainGradientColor1, for: .normal)
//		button.setTitle("Next▶︎", for: .normal)
//		button.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 14.0)
//		button.addTarget(self, action: #selector(scrollNext), for: .touchUpInside)
//		return button
//	}()
//
//	let previousButton: UIButton = {
//		let button = UIButton()
//		button.setTitleColor(UIColor.lightGray, for: .normal)
//		button.setTitle("◀︎Previous", for: .normal)
//		button.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 14.0)
//		button.addTarget(self, action: #selector(scrollBack), for: .touchUpInside)
//		return button
//	}()
//
    override func viewDidLoad() {
        super.viewDidLoad()
		
		dataSource = self
		delegate = self
		loadTutorials()
		setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)
		configureAutolayout()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
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
		pageControl.isUserInteractionEnabled = false
		pageControl.currentPageIndicatorTintColor = SharedStyleKit.mainGradientColor1
		pageControl.pageIndicatorTintColor = UIColor.lightGray
		pageControl.currentPage = 0
		view.addSubview(pageControl)
	
		pageControl.autoPinEdges(toSuperviewMarginsExcludingEdge: .top)
		
//		view.addSubview(nextButton)
//		nextButton.autoPinEdge(toSuperviewMargin: .right)
//		nextButton.autoPinEdge(toSuperviewMargin: .bottom)
//		nextButton.autoMatch(.height, to: .height, of: pageControl, withOffset: 0.0)
//		
//		view.addSubview(previousButton)
//		previousButton.autoPinEdge(toSuperviewMargin: .left)
//		previousButton.autoPinEdge(toSuperviewMargin: .bottom)
//		previousButton.autoMatch(.height, to: .height, of: pageControl, withOffset: 0.0)
	}
	
	@objc fileprivate func dismissViewController() {
		dismissViewController();
	}
	
	@objc fileprivate func scrollNext() {
		setViewControllers([pages[pageControl.currentPage + 1]], direction: .forward, animated: true, completion: nil)
		pageControl.currentPage += 1
	}
	
	@objc fileprivate func scrollBack() {
		setViewControllers([pages[pageControl.currentPage - 1]], direction: .reverse, animated: true, completion: nil)
		pageControl.currentPage -= 1
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
//				previousButton.isHidden = true
				return nil
			} else {
//				nextButton.isHidden = false
//				previousButton.isHidden = false
				return self.pages[viewControllerIndex - 1]
			}
		}
		return nil
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		if let viewControllerIndex = self.pages.index(of: viewController) {
			if viewControllerIndex < self.pages.count - 1 {
//				nextButton.isHidden = false
//				previousButton.isHidden = false
				return self.pages[viewControllerIndex + 1]
			} else {
//				nextButton.isHidden = true
				return nil
			}
		}
		return nil
	}
}
