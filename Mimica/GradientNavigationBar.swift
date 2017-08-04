//
//  Gradientself.swift
//  Mimica
//
//  Created by Gleb Linnik on 04.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit
//TODO: Refactor this fucking hardcode
@IBDesignable class GradientNavigationBar: UINavigationBar {
	@IBInspectable var firstColor:UIColor = SharedStyleKit.mainGradientColor
	@IBInspectable var secondColor:UIColor = SharedStyleKit.mainGradientColor2
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.tintColor = .white
		
		let gradient = CAGradientLayer()
		gradient.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.statusBarFrame.width,
		                        height: UIApplication.shared.statusBarFrame.height + self.frame.height)
		gradient.locations = [0.0, 1.0]
		gradient.colors = [firstColor.cgColor, secondColor.cgColor]
		var image: UIImage? = nil
		UIGraphicsBeginImageContext(gradient.frame.size)
		if let context = UIGraphicsGetCurrentContext() {
			gradient.render(in: context)
			image = UIGraphicsGetImageFromCurrentImageContext()
		}
		UIGraphicsEndImageContext()
		self.setBackgroundImage(image, for: .default)
	}

}
