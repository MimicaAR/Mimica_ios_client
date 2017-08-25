//
//  GradientTabBarViewController.swift
//  Mimica
//
//  Created by Gleb Linnik on 18.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class GradientTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		setupViewControllers()
		makeAllImagesGradient()
    }
	
	private func setupViewControllers() {
		let homeViewController = UINavigationController(rootViewController: HomeViewController())
		homeViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Home icon"), tag: 1)
		
		let exercisingViewController = ExercisingViewController()
		exercisingViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Play icon"), tag: 2)
		
		let view3 = UIViewController()
		view3.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Chat icon"), tag: 3)
		
		self.viewControllers = [homeViewController, exercisingViewController, view3]
	}
	
	private func makeAllImagesGradient() {
		for item in self.tabBar.items! {
			item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
			item.selectedImage = UIImage.tint(image: item.selectedImage!,
			                                  gradient: SharedStyleKit.mainGradient)
			item.selectedImage = item.selectedImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
		}
	}
}
