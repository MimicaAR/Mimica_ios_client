//
//  ProgressViewController.swift
//  Mimica
//
//  Created by Gleb Linnik on 24.09.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    @IBOutlet var topBarLabels: [UILabel]!
    @IBOutlet var separators: [UIView]!
    
    @IBOutlet weak var exerecisingStatsLabel: UILabel!
    @IBOutlet weak var timeStatsLabel: UILabel!
    @IBOutlet weak var progressStatsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.navigationBar.topItem?.title = "Progress"
		
		configureSeparators()
		configureTopLabels()
		configureExercisesLabel(13, outOf: 75)
		configureProgressLabel(72, true)
    }
	
	private func configureSeparators() {
		for separator in separators {
			separator.backgroundColor = SharedStyleKit.calendarCellBorderColor
		}
	}
	
	private func configureTopLabels() {
		for label in topBarLabels {
			label.textColor = SharedStyleKit.calendarCellDateColor
		}
	}
	
	func configureExercisesLabel(_ exercises: Int, outOf overalExercises: Int) {
		let attributedText = NSMutableAttributedString(string: "\(exercises)",
			attributes: [NSFontAttributeName : UIFont(name: "Rubik-Medium",
			                                          size: 21.0) ?? .systemFont(ofSize: 21.0),
			             NSForegroundColorAttributeName : SharedStyleKit.calendarCellTitleColor])
		attributedText.append(NSAttributedString(string: " / \(overalExercises)",
			attributes: [NSFontAttributeName : UIFont(name: "Rubik-Regular",
			                                          size: 14.0) ?? .systemFont(ofSize: 14.0),
			             NSForegroundColorAttributeName : SharedStyleKit.calendarCellSelectedColor]))
		exerecisingStatsLabel.attributedText = attributedText
	}
	
	func configureProgressLabel(_ persent: Int, _ isGood: Bool) {
		let attributedText = NSMutableAttributedString(string: "·",
            attributes: [NSFontAttributeName : UIFont(name: "Rubik-Medium",
                                                      size: 21.0) ?? .systemFont(ofSize: 21.0),
                         NSForegroundColorAttributeName : isGood ? UIColor.green : .red])
		attributedText.append(NSAttributedString(string: " \(persent)%",
			attributes: [NSForegroundColorAttributeName : SharedStyleKit.calendarCellTitleColor]))
		
		progressStatsLabel.attributedText = attributedText
	}
}
