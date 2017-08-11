//
//  GradientTabBar.swift
//  Mimica
//
//  Created by Gleb Linnik on 05.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class GradientTabBar: UITabBar {
	@IBInspectable var firstColor:UIColor = .white
	@IBInspectable var secondColor:UIColor = .black
	override func awakeFromNib() {
		super.awakeFromNib()
		for item in self.items! {
			item.selectedImage = item.selectedImage?.tint(colors: [firstColor, secondColor])
			item.selectedImage = item.selectedImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
		}
	}
}
