//
//  Gradientself.swift
//  Mimica
//
//  Created by Gleb Linnik on 04.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class GradientNavigationBar: UINavigationBar {
	@IBInspectable var firstColor:UIColor = .white {
		didSet {
			self.drawGradient()
		}
	}
	@IBInspectable var secondColor:UIColor = .black {
		didSet {
			self.drawGradient()
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.drawGradient()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.drawGradient()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.drawGradient()
	}
	
	func drawGradient() {
		let gradient = CAGradientLayer()
		gradient.frame = CGRect(x: 0,
		                        y: -UIApplication.shared.statusBarFrame.height,
		                        width: UIApplication.shared.statusBarFrame.width,
		                        height: UIApplication.shared.statusBarFrame.height + self.frame.height)
		gradient.locations = [0.0, 1.0]
		gradient.colors = [firstColor.cgColor, secondColor.cgColor]
		self.layer.addSublayer(gradient)
		self.backgroundColor = .clear
	}

}
