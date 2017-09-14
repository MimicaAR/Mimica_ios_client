//
//  SocialMediaLoginView.swift
//  Mimica
//
//  Created by Gleb Linnik on 14/09/2017.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class SocialMediaLoginView: UIView {
	
	let leftSeparatorLine: UIView = {
		let view = UIView()
		view.backgroundColor = SharedStyleKit.calendarCellBorderColor
		return view
	}()
	
	let rightSeparatorLine: UIView = {
		let view = UIView()
		view.backgroundColor = SharedStyleKit.calendarCellBorderColor
		return view
	}()
	
	let alternativeLabel: UILabel = {
		let label = UILabel()
		label.text = "OR SIGN IN WITH"
		label.font = UIFont(name: "Rubik-Regular", size: 14.0)
		label.textColor = SharedStyleKit.calendarCellDateColor
		return label
	}()
	
	let facebookButton: UIButton = {
		let size: CGFloat = 60.0
		let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: size, height: size))
		button.setImage(#imageLiteral(resourceName: "facebook"), for: .normal)
		button.backgroundColor = SharedStyleKit.facebookColor
		button.layer.cornerRadius = size / 2
		button.clipsToBounds = true
		return button
	}()
	
	let twitterButton: UIButton = {
		let size: CGFloat = 60.0
		let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: size, height: size))
		button.setImage(#imageLiteral(resourceName: "twitter"), for: .normal)
		button.backgroundColor = SharedStyleKit.twitterColor
		button.layer.cornerRadius = size / 2
		button.clipsToBounds = true
		return button
	}()
	
	let googleButton: UIButton = {
		let size: CGFloat = 60.0
		let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: size, height: size))
		button.setImage(#imageLiteral(resourceName: "google"), for: .normal)
		button.backgroundColor = SharedStyleKit.googleColor
		button.layer.cornerRadius = size / 2
		button.clipsToBounds = true
		return button
	}()
	
	let supportButton: UIButton = {
		let button = UIButton()
		button.setTitle("Support", for: .normal)
		button.setTitleColor(SharedStyleKit.calendarCellDateColor, for: .normal)
		button.setTitleColor(SharedStyleKit.calendarCellTitleColor, for: .highlighted)
		button.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 14.0)
		return button
	}()
	
	let createAccountButton: UIButton = {
		let button = UIButton()
		button.setTitle("Create account", for: .normal)
		button.setTitleColor(SharedStyleKit.calendarCellDateColor, for: .normal)
		button.setTitleColor(SharedStyleKit.calendarCellTitleColor, for: .highlighted)
		button.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 14.0)
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureViews() {
		addSubview(facebookButton)
		addSubview(twitterButton)
		addSubview(googleButton)
		addSubview(leftSeparatorLine)
		addSubview(rightSeparatorLine)
		addSubview(alternativeLabel)
		addSubview(supportButton)
		addSubview(createAccountButton)
		
		addConstraints(withFormat: "H:|[v0]-15-[v1]-15-[v2]|", views: leftSeparatorLine, alternativeLabel, rightSeparatorLine)
		addConstraints(withFormat: "V:|[v0]", views: alternativeLabel)
		addConstraints(withFormat: "V:[v0(1)]", views: leftSeparatorLine)
		addConstraints(withFormat: "V:[v0(1)]", views: rightSeparatorLine)
		alternativeLabel.autoAlignAxis(toSuperviewAxis: .vertical)
		leftSeparatorLine.autoAlignAxis(.horizontal, toSameAxisOf: alternativeLabel)
		rightSeparatorLine.autoAlignAxis(.horizontal, toSameAxisOf: alternativeLabel)
		
		addConstraints(withFormat: "V:[v0(60)]", views: twitterButton)
		addConstraints(withFormat: "H:[v0(60)]", views: twitterButton)
		
		twitterButton.autoCenterInSuperview()
		facebookButton.autoAlignAxis(.horizontal, toSameAxisOf: twitterButton)
		googleButton.autoAlignAxis(.horizontal, toSameAxisOf: twitterButton)
		
		addConstraints(withFormat: "H:|-20-[v0(60)]", views: facebookButton)
		addConstraints(withFormat: "V:[v0(60)]", views: facebookButton)
		addConstraints(withFormat: "H:[v0(60)]-20-|", views: googleButton)
		addConstraints(withFormat: "V:[v0(60)]", views: googleButton)
		addConstraints(withFormat: "H:|[v0]", views: supportButton)
		addConstraints(withFormat: "V:[v0]|", views: supportButton)
		addConstraints(withFormat: "H:[v0]|", views: createAccountButton)
		addConstraints(withFormat: "V:[v0]|", views: createAccountButton)
	}
}
