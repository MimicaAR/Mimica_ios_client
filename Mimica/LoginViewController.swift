//
//  LoginViewController.swift
//  Mimica
//
//  Created by Gleb Linnik on 18.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	let loginView = LoginView()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view = UIView(frame: UIScreen.main.bounds)
		setupViews()
    }
	
	private func setupViews() {
		view.backgroundColor = .white
		view.addSubview(loginView)
		view.addConstraints(withFormat: "V:[v0(310)]", views: loginView)
		view.addConstraints(withFormat: "H:|-[v0]-|", views: loginView)
		NSLayoutConstraint(item: loginView,
		                   attribute: .centerY,
		                   relatedBy: .equal,
		                   toItem: self.view,
		                   attribute: .centerY,
		                   multiplier: 1,
		                   constant: 0).isActive = true
	}
}

class LoginView: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//Login view
	let loginImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage())
		imageView.image = UIImage.tint(image: #imageLiteral(resourceName: "Login icon"),
		                               gradient: SharedStyleKit.mainGradient)
		return imageView
	}()
	
	let loginTextField: UITextField = {
		let field = UITextField()
		field.font = UIFont(name: "Rubik-Regular", size: 17.0)
		field.placeholder = "E-mail or phone number"
		field.textColor = SharedStyleKit.calendarCellTitleColor
		return field
	}()
	
	let loginSeparatorLine: UIView = {
		let view = UIView()
		view.backgroundColor = SharedStyleKit.calendarCellBorderColor
		return view
	}()
	
	let loginView = UIView()
	
	
	//Password view
	let passwordImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage())
		imageView.image = UIImage.tint(image: #imageLiteral(resourceName: "Password icon"),
		                               gradient: SharedStyleKit.mainGradient)
		return imageView
	}()
	
	let passwordTextField: UITextField = {
		let field = UITextField()
		field.font = UIFont(name: "Rubik-Regular", size: 17.0)
		field.textColor = SharedStyleKit.calendarCellTitleColor
		field.placeholder = "Password"
		field.isSecureTextEntry = true
		return field
	}()
	
	let passwordSeparatorLine: UIView = {
		let view = UIView()
		view.backgroundColor = SharedStyleKit.calendarCellBorderColor
		return view
	}()
	
	let passwordView = UIView()
	
	
	let loginButton: UIButton = {
		let button = UIButton()
		button.setTitle("LOG IN", for: .normal)
		button.setTitleColor(UIColor(white: 1.0, alpha: 0.9), for: .normal)
		button.setTitleColor(UIColor(white: 1.0, alpha: 0.5), for: .highlighted)
		button.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 17.0)
		button.backgroundColor = SharedStyleKit.loginButtonColor
		button.layer.cornerRadius = 24.0
		return button
	}()
	
	let restorePasswordButton: UIButton = {
		let button = UIButton()
		button.setTitle("Restore the password", for: .normal)
		button.setTitleColor(SharedStyleKit.loginButtonColor, for: .normal)
		button.setTitleColor(SharedStyleKit.mainGradientColor2, for: .highlighted)
		button.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 14.0)
		return button
	}()
	
	private func setupViews() {
		setupViewBackground()
		
		layoutViews()
		
		configureLoginView()
		configurePasswordView()
	}
	
	private func setupViewBackground() {
		self.backgroundColor = .white
		self.layer.cornerRadius = 20.0
		self.layer.borderColor = SharedStyleKit.loginViewBorderColor.cgColor
		self.layer.borderWidth = 1.0
		//Shadow
		self.layer.shadowRadius = 20
		self.layer.shadowOffset = CGSize(width: 0, height: 2)
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOpacity = 0.10
	}
	
	private func configureLoginView() {
		loginView.addSubview(loginImageView)
		loginView.addSubview(loginTextField)
		loginView.addSubview(loginSeparatorLine)
		
		addConstraints(withFormat: "H:|[v0(21)]-19-[v1]|", views: loginImageView, loginTextField)
		addConstraints(withFormat: "H:|-39-[v0]|", views: loginSeparatorLine)
		addConstraints(withFormat: "V:|-2-[v0(20)]", views: loginImageView)
		addConstraints(withFormat: "V:|[v0]", views: loginTextField)
		addConstraints(withFormat: "V:[v0(1)]-1-|", views: loginSeparatorLine)
	}
	
	private func configurePasswordView() {
		passwordView.addSubview(passwordImageView)
		passwordView.addSubview(passwordTextField)
		passwordView.addSubview(passwordSeparatorLine)
		
		addConstraints(withFormat: "H:|-2-[v0(17)]-19-[v1]|", views: passwordImageView, passwordTextField)
		addConstraints(withFormat: "H:|-39-[v0]|", views: passwordSeparatorLine)
		addConstraints(withFormat: "V:|-2-[v0]", views: passwordImageView)
		addConstraints(withFormat: "V:|[v0]", views: passwordTextField)
		addConstraints(withFormat: "V:[v0(1)]-1-|", views: passwordSeparatorLine)
	}
	
	private func layoutViews() {
		addSubview(loginView)
		addSubview(passwordView)
		addSubview(loginButton)
		addSubview(restorePasswordButton)
		
		addConstraints(withFormat: "V:|-55-[v0(34)]-25-[v1(34)]", views: loginView, passwordView)
		addConstraints(withFormat: "V:[v0(48)]-25-[v1]-25-|", views: loginButton, restorePasswordButton)
		addConstraints(withFormat: "H:|-30-[v0]-30-|", views: loginView)
		addConstraints(withFormat: "H:|-30-[v0]-30-|", views: passwordView)
		addConstraints(withFormat: "H:|-30-[v0]-30-|", views: loginButton)
		NSLayoutConstraint(item: restorePasswordButton,
		                   attribute: .centerX,
		                   relatedBy: .equal,
		                   toItem: self,
		                   attribute: .centerX,
		                   multiplier: 1,
		                   constant: 0).isActive = true
	}
}
















