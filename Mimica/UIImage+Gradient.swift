//
//  UIImage+Gradient.swift
//  Mimica
//
//  Created by Gleb Linnik on 05.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
	func tint(colors: [UIColor]) -> UIImage {
		// Create gradient
		
		let colorOne = colors[0]
		let colorTwo = colors[1]
		
		let colors = [colorOne.cgColor, colorTwo.cgColor]
		
		let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
		                          colors: colors as CFArray,
		                          locations: [1.0, 0.0]);
		
		return self.tint(gradient: gradient!)
	}
	
	func tint(gradient: CGGradient) -> UIImage {
		// Load image
		let scale = self.scale
		UIGraphicsBeginImageContext(CGSize(width: self.size.width * scale, height: self.size.height * scale))
		let context = UIGraphicsGetCurrentContext()
		context?.translateBy(x: 0, y: self.size.height * scale)
		context?.scaleBy(x: 1.0, y: -1.0)
		
		context?.setBlendMode(CGBlendMode.normal)
		let rect = CGRect(x: 0, y: 0, width: self.size.width * scale, height: self.size.height * scale)
		context?.draw(self.cgImage!, in: rect)
		
		// Apply gradient
		
		context!.clip(to: rect, mask: self.cgImage!)
		context!.drawLinearGradient(gradient,
		                            start: CGPoint(x: 0, y: 0),
		                            end: CGPoint(x: 0, y: self.size.height * scale),
		                            options: CGGradientDrawingOptions(rawValue: 0))
		let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return UIImage.init(cgImage: (gradientImage?.cgImage)!,
		                    scale: scale,
		                    orientation: (gradientImage?.imageOrientation)!)
	}
}
