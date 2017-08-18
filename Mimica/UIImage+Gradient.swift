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
	class func tint(image: UIImage, colors: [UIColor]) -> UIImage {
		// Create gradient
		
		let colorOne = colors[0]
		let colorTwo = colors[1]
		
		let colors = [colorOne.cgColor, colorTwo.cgColor]
		
		let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
		                          colors: colors as CFArray,
		                          locations: [1.0, 0.0]);
		
		return UIImage.tint(image: image, gradient: gradient!)
	}
	
	class func tint(image: UIImage, gradient: CGGradient) -> UIImage {
		// Load image
		let scale = image.scale
		UIGraphicsBeginImageContext(CGSize(width: image.size.width * scale, height: image.size.height * scale))
		let context = UIGraphicsGetCurrentContext()
		context?.translateBy(x: 0, y: image.size.height * scale)
		context?.scaleBy(x: 1.0, y: -1.0)
		
		context?.setBlendMode(CGBlendMode.normal)
		let rect = CGRect(x: 0, y: 0, width: image.size.width * scale, height: image.size.height * scale)
		context?.draw(image.cgImage!, in: rect)
		
		// Apply gradient
		
		context!.clip(to: rect, mask: image.cgImage!)
		context!.drawLinearGradient(gradient,
		                            start: CGPoint(x: 0, y: 0),
		                            end: CGPoint(x: 0, y: image.size.height * scale),
		                            options: CGGradientDrawingOptions(rawValue: 0))
		let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return UIImage.init(cgImage: (gradientImage?.cgImage)!,
		                    scale: scale,
		                    orientation: (gradientImage?.imageOrientation)!)
	}
}
