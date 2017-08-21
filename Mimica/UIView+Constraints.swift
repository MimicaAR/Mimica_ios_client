//
//  UIView+Constraints.swift
//  Mimica
//
//  Created by Gleb Linnik on 19.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

extension UIView {
	func addConstraints(withFormat format: String, views: UIView...) {
		var viewsDictionary = [String : UIView]()
		for (index, view) in views.enumerated() {
			let key = "v\(index)"
			viewsDictionary[key] = view
			view.translatesAutoresizingMaskIntoConstraints = false
		}
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
		                                              options: [],
		                                              metrics: nil,
		                                              views: viewsDictionary))
	}
}
