//
//  CalendarTableViewCell.swift
//  Mimica
//
//  Created by Gleb Linnik on 11.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var isSelected: Bool {
		didSet {
			self.backgroundColor = isSelected ? SharedStyleKit.calendarCellSelectedColor : .white
		}
	}
	
	override var isHighlighted: Bool {
		didSet {
			self.backgroundColor = isHighlighted ? SharedStyleKit.calendarCellSelectedColor : .white
		}
	}
	
	private let dateLabel: UILabel = UILabel()
	
	private let titleLabel: UILabel = UILabel()
	
	var dateText: String? {
		get {
			return dateLabel.text
		}
		set {
			if let string = newValue {
				configureDateText(withString: string)
			}
		}
	}
	
	var titleText: String? {
		get {
			return titleLabel.text
		}
		set {
			if let string = newValue {
				configureTitleText(withString: string)
			}
		}
	}
	
	private func setupViews() {
		configureCellBg()
		configureDateText(withString: "Aug 20\n11:00")
		configureTitleText(withString: "Routine examination in clinic")
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
	
	private func configureDateText(withString string: String) {
		dateLabel.numberOfLines = 2
		let font = UIFont(name: "Rubik-Regular", size: 14.00)
		
		let paragraph = NSMutableParagraphStyle()
		paragraph.paragraphSpacing = 0.20 * (font?.lineHeight)!
		
		dateLabel.attributedText =
			NSMutableAttributedString(string: string,
			                          attributes: [NSFontAttributeName : font!,
			                                       NSForegroundColorAttributeName : SharedStyleKit.calendarCellDateColor,
			                                       NSParagraphStyleAttributeName : paragraph])
	}
	
	private func configureTitleText(withString string: String) {
		titleLabel.numberOfLines = 2
		let font = UIFont(name: "Rubik-Medium", size: 14.00)
		
		let paragraph = NSMutableParagraphStyle()
		paragraph.paragraphSpacing = 0.17 * (font?.lineHeight)!
		
		titleLabel.attributedText =
			NSMutableAttributedString(string: string,
			                          attributes: [NSFontAttributeName : font!,
			                                       NSForegroundColorAttributeName : SharedStyleKit.calendarCellTitleColor,
			                                       NSParagraphStyleAttributeName : paragraph])
	}
	
	private func layoutLabels() {
		addConstraints(withFormat: "H:|-20-[v0(60)]-10-[v1]-20-|", views: dateLabel, titleLabel)
		addConstraints(withFormat: "V:|-11-[v0]-11-|", views: titleLabel)
		addConstraints(withFormat: "V:|-11-[v0]-11-|", views: dateLabel)
	}
}
