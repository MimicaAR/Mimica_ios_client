//
//  GlobalAppearanceManager.swift
//  Mimica
//
//  Created by Gleb Linnik on 11.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class GlobalAppearanceManager: NSObject {
	override init() {
		let font: UIFont = UIFont(name: "Rubik-Medium", size: 11.0)!
		UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
	}
}
