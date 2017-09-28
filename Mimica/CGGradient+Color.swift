//
//  CGGradient+Color.swift
//  Mimica
//
//  Created by Gleb Linnik on 24.09.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import Foundation
import UIKit

extension CGGradient {
	class func gradient(withColors topColor: UIColor, bottomColor: UIColor) -> CGGradient{
		let colorOne = topColor
		let colorTwo = bottomColor
		
		let colors = [colorOne.cgColor, colorTwo.cgColor]
		
		let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
		                          colors: colors as CFArray,
		                          locations: [1.0, 0.0]);
		return gradient!
	}
}
