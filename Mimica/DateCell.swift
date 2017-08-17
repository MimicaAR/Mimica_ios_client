//
//  CalendarTableViewCell.swift
//  Mimica
//
//  Created by Gleb Linnik on 11.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell {
	
	let dateLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 2
		
		let font = UIFont(name: "Rubik-Regular", size: 14.00)
		
		let paragraph = NSMutableParagraphStyle()
		paragraph.paragraphSpacing = 0.20 * (font?.lineHeight)!
		
		label.attributedText =
			NSMutableAttributedString(string: "Aug 10\n11:00",
			                          attributes: [NSFontAttributeName : font!,
			                                       NSForegroundColorAttributeName : SharedStyleKit.calendarCellDateColor,
			                                       NSParagraphStyleAttributeName : paragraph])
		return label
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 2
		
		let font = UIFont(name: "Rubik-Medium", size: 14.00)
		
		let paragraph = NSMutableParagraphStyle()
		paragraph.paragraphSpacing = 0.17 * (font?.lineHeight)!
		
		label.attributedText =
			NSMutableAttributedString(string: "Routine examination in clinic",
			                          attributes: [NSFontAttributeName : font!,
			                                       NSForegroundColorAttributeName : SharedStyleKit.calendarCellTitleColor,
			                                       NSParagraphStyleAttributeName : paragraph])
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupViews() {
		configureCellBg()
		addSubview(dateLabel)
		addSubview(titleLabel)
		layoutLabels()
	}
	
	private func configureCellBg() {
		layer.cornerRadius = 5.0
		layer.borderWidth = 1.0
		layer.borderColor = SharedStyleKit.calendarCellBorderColor.cgColor
		clipsToBounds = true
		backgroundColor = .white
	}
	
	private func layoutLabels() {
		let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[dateLabel(60)]-10-[titleLabel]-20-|",
		                                                           options: [],
		                                                           metrics: nil,
		                                                           views: ["titleLabel" : titleLabel,
		                                                                   "dateLabel" : dateLabel])
		
		let verticalTitleConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-11-[titleLabel]-11-|",
		                                                         options: [],
		                                                         metrics: nil,
		                                                         views: ["titleLabel" : titleLabel])
		
		let verticalDateConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-11-[dateLabel]-11-|",
		                                                             options: [],
		                                                             metrics: nil,
		                                                             views: ["dateLabel" : dateLabel])
		self.addConstraints(horizontalConstraints)
		self.addConstraints(verticalTitleConstraints)
		self.addConstraints(verticalDateConstraints)
		dateLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
	}
}
