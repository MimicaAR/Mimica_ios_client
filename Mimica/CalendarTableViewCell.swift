//
//  CalendarTableViewCell.swift
//  Mimica
//
//  Created by Gleb Linnik on 11.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var bgRoundedView: UIView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		self.contentView.backgroundColor = SharedStyleKit.calendarCellBgColor
		if selected {
			self.bgRoundedView.backgroundColor = SharedStyleKit.calendarCellHighlitedColor
		} else {
			self.bgRoundedView.backgroundColor = .white
		}
    }

}
