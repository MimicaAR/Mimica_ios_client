//
//  GradientTabBar.swift
//  Mimica
//
//  Created by Gleb Linnik on 05.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class GradientTabBar: UITabBar {
	override init(frame: CGRect) {
		super.init(frame: frame)
		for item in self.items! {
			item.selectedImage = item.selectedImage?.tint(gradient: SharedStyleKit.mainGradient)
			item.selectedImage = item.selectedImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}
