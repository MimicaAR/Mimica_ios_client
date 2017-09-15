//
//  SignUpView.swift
//  Mimica
//
//  Created by Gleb Linnik on 15.09.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class SignUpView: UIView {

	@IBOutlet weak var signUpButton: UIButton!
	
	@IBOutlet weak var loginTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var repeatPasswordTextField: UITextField!
	
	
	@IBOutlet weak var loginIcon: UIImageView!
	@IBOutlet weak var passwordIcon: UIImageView!
	@IBOutlet weak var repeatPasswordIcon: UIImageView!
	@IBOutlet var separators: [UIView]!
	
	public var textFieldsDelegate: UITextFieldDelegate? {
		get { return loginTextField.delegate }
		set {
			loginTextField.delegate = newValue
			passwordTextField.delegate = newValue
			repeatPasswordTextField.delegate = newValue
		}
	}
	
	override func awakeFromNib() {
		 configureViews()
	}
	
	private func configureViews() {
		configureBackground()
		configureSeparators()
		configureButton()
		configureTextFields()
		tintIcons()
	}
	
	private func configureBackground() {
		layer.cornerRadius = 20.0
		//Shadow
		layer.shadowRadius = 20
		layer.shadowOffset = CGSize(width: 0, height: 2)
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.20
	}
	
	private func configureSeparators() {
		for separator in separators {
			separator.backgroundColor = SharedStyleKit.calendarCellBorderColor
		}
	}
	
	private func configureButton() {
		signUpButton.setTitleColor(UIColor(white: 1.0, alpha: 0.9), for: .normal)
		signUpButton.setTitleColor(UIColor(white: 1.0, alpha: 0.5), for: .highlighted)
		signUpButton.backgroundColor = SharedStyleKit.loginButtonColor
		signUpButton.layer.cornerRadius = signUpButton.bounds.height / 2
	}
	
	private func configureTextFields() {
		loginTextField.textColor = SharedStyleKit.calendarCellTitleColor
		passwordTextField.textColor = SharedStyleKit.calendarCellTitleColor
		repeatPasswordTextField.textColor = SharedStyleKit.calendarCellTitleColor
		
		passwordTextField.isSecureTextEntry = true
		repeatPasswordTextField.isSecureTextEntry = true
	}
	
	private func tintIcons() {
		loginIcon.image = UIImage.tint(image: loginIcon.image!,
		                               gradient: SharedStyleKit.mainGradient)
		passwordIcon.image = UIImage.tint(image: passwordIcon.image!,
		                                  gradient: SharedStyleKit.mainGradient)
		repeatPasswordIcon.image = UIImage.tint(image: repeatPasswordIcon.image!,
		                                        gradient: SharedStyleKit.mainGradient)
	}
}
