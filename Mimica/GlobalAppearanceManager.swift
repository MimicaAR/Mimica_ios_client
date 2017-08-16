//
//  GlobalAppearanceManager.swift
//  Mimica
//
//  Created by Gleb Linnik on 11.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class GlobalAppearanceManager: NSObject {
	private let navigationBarHeight: CGFloat = 44.0
	
	override init() {
		let font: UIFont = UIFont(name: "Rubik-Medium", size: 11.0)!
		UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
		
		let navigationBar = UINavigationBar.appearance()
		navigationBar.tintColor = .white
		let gradient = CAGradientLayer()
		gradient.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.statusBarFrame.width,
		                        height: UIApplication.shared.statusBarFrame.height + navigationBarHeight)
		gradient.locations = [0.0, 1.0]
		gradient.colors = [SharedStyleKit.mainGradientColor.cgColor, SharedStyleKit.mainGradientColor2.cgColor]
		var image: UIImage? = nil
		UIGraphicsBeginImageContext(gradient.frame.size)
		if let context = UIGraphicsGetCurrentContext() {
			gradient.render(in: context)
			image = UIGraphicsGetImageFromCurrentImageContext()
		}
		UIGraphicsEndImageContext()
		navigationBar.setBackgroundImage(image, for: .default)

	}
}
