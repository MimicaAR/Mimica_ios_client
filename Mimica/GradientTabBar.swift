//
//  GradientTabBar.swift
//  Mimica
//
//  Created by Gleb Linnik on 05.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

@IBDesignable class GradientTabBar: UITabBar {
	override func awakeFromNib() {
		super.awakeFromNib()
		for item in self.items! {
			item.selectedImage = item.selectedImage?.tint(gradient: SharedStyleKit.mainGradient)
			item.selectedImage = item.selectedImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
		}
	}

}
