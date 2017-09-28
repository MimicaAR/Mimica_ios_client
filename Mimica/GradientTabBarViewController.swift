//
//  GradientTabBarViewController.swift
//  Mimica
//
//  Created by Gleb Linnik on 18.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class GradientTabBarViewController: UITabBarController {
	
	private var gradient: CGGradient
	
	convenience init(withColors topColor: UIColor, bottomColor: UIColor) {
		self.init(withGradint: CGGradient.gradient(withColors: topColor, bottomColor: bottomColor))
	}
	
	init(withGradint gradient: CGGradient) {
		self.gradient = gradient
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		self.gradient = CGGradient(colorsSpace: nil, colors: [SharedStyleKit.mainGradientColor2.cgColor, SharedStyleKit.mainGradientColor1.cgColor] as CFArray, locations: [0, 1])!
		super.init(coder: aDecoder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupViewControllers()
		makeAllImagesGradient()
    }
	
	private func setupViewControllers() {
		let homeTab = UINavigationController(rootViewController: HomeViewController())
		homeTab.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Home icon"), tag: 1)
		
		let view2 = UIViewController()
		view2.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Play icon"), tag: 2)
		
		let progressTab = UINavigationController(rootViewController: ProgressViewController())
		progressTab.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Progress icon"), tag: 3)
		
		self.viewControllers = [homeTab, view2, progressTab]
	}
	
	private func makeAllImagesGradient() {
		for item in self.tabBar.items! {
			
			item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
			item.selectedImage = UIImage.tint(image: item.selectedImage!, gradient: gradient)
			item.selectedImage = item.selectedImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
		}
	}
}
