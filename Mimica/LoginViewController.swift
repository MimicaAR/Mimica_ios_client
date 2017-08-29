//
//  LoginViewController.swift
//  Mimica
//
//  Created by Gleb Linnik on 18.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit
import PureLayout
import Firebase
import FirebaseAuth

@available(iOS 9.0, *)
class LoginViewController: UIViewController, UITextFieldDelegate {
	
	let loginView = LoginView()
	let logoImage = UIImageView(image: #imageLiteral(resourceName: "Launch logo"))
	let bottomView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		return view
	}()
	
	let buttonsContainerView = UIView()
	
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
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view = UIView(frame: UIScreen.main.bounds)
		setupViews()
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		UIView.animate(withDuration: 0.5,
		               delay: 0.0,
		               options: .curveEaseInOut,
		               animations: {
						self.logoImage.center.y = (self.view.center.y - self.loginView.bounds.height / 2) / 2
		},
		               completion: { (completed: Bool) in
						UIView.animate(withDuration: 0.5,
						               delay: 0.0,
						               options: .curveEaseOut,
						               animations: {
										self.loginView.autoAlignAxis(.horizontal,
										                             toSameAxisOf: self.view,
										                             withOffset: self.view.bounds.height < 569 ? -25 : 0)
										self.loginView.autoPinEdge(toSuperviewMargin: .left)
										self.loginView.autoPinEdge(toSuperviewMargin: .right)
										self.view.addConstraints(withFormat: "V:[v0(>=256,<=310)]-20-[v1(<=138)]-|",
										                         views: self.loginView, self.buttonsContainerView)
										self.view.layoutIfNeeded()
										self.loginView.loginButton.layer.cornerRadius = self.loginView.loginButton.frame.height / 2
										UIView.animate(withDuration: 0.5,
										               delay: 0.3,
										               options: .curveEaseOut,
										               animations: {
														self.bottomView.frame.origin = CGPoint(x: 0, y: self.view.bounds.height / 2)
										},
										               completion: nil)
						},
						               completion: nil)
		})
	}
	
	private func setupViews() {
		configureBGView()
		configureLogo()
		configureBootomView()
		configureLoginView()
	}
	
	private func configureBGView() {
		view.backgroundColor = .white
		let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "Loading screen"))
		view.addSubview(backgroundImageView)
		backgroundImageView.autoPinEdgesToSuperviewEdges()
	}
	
	private func configureLogo() {
		logoImage.center = view.center
		view.addSubview(logoImage)
	}
	
	private func configureBootomView() {
		bottomView.frame = CGRect(x: 0, y: self.view.bounds.height,
		                          width: self.view.bounds.width, height: self.view.bounds.height / 2)
		view.addSubview(bottomView)
		bottomView.addSubview(buttonsContainerView)
		bottomView.addConstraints(withFormat: "H:|-(20)-[v0]-(20)-|", views: buttonsContainerView)
		bottomView.addConstraints(withFormat: "V:[v0]-|", views: buttonsContainerView)
		
		buttonsContainerView.addSubview(facebookButton)
		buttonsContainerView.addSubview(twitterButton)
		buttonsContainerView.addSubview(googleButton)
		buttonsContainerView.addSubview(leftSeparatorLine)
		buttonsContainerView.addSubview(rightSeparatorLine)
		buttonsContainerView.addSubview(alternativeLabel)
		buttonsContainerView.addSubview(supportButton)
		buttonsContainerView.addSubview(createAccountButton)
		
		buttonsContainerView.addConstraints(withFormat: "H:|[v0]-15-[v1]-15-[v2]|", views: leftSeparatorLine, alternativeLabel, rightSeparatorLine)
		buttonsContainerView.addConstraints(withFormat: "V:|[v0]", views: alternativeLabel)
		buttonsContainerView.addConstraints(withFormat: "V:[v0(1)]", views: leftSeparatorLine)
		buttonsContainerView.addConstraints(withFormat: "V:[v0(1)]", views: rightSeparatorLine)
		alternativeLabel.autoAlignAxis(toSuperviewAxis: .vertical)
		leftSeparatorLine.autoAlignAxis(.horizontal, toSameAxisOf: alternativeLabel)
		rightSeparatorLine.autoAlignAxis(.horizontal, toSameAxisOf: alternativeLabel)
		
		buttonsContainerView.addConstraints(withFormat: "V:[v0(60)]", views: twitterButton)
		buttonsContainerView.addConstraints(withFormat: "H:[v0(60)]", views: twitterButton)
		
		twitterButton.autoCenterInSuperview()
		facebookButton.autoAlignAxis(.horizontal, toSameAxisOf: twitterButton)
		googleButton.autoAlignAxis(.horizontal, toSameAxisOf: twitterButton)
		
		buttonsContainerView.addConstraints(withFormat: "H:|-20-[v0(60)]", views: facebookButton)
		buttonsContainerView.addConstraints(withFormat: "V:[v0(60)]", views: facebookButton)
		buttonsContainerView.addConstraints(withFormat: "H:[v0(60)]-20-|", views: googleButton)
		buttonsContainerView.addConstraints(withFormat: "V:[v0(60)]", views: googleButton)
		buttonsContainerView.addConstraints(withFormat: "H:|[v0]", views: supportButton)
		buttonsContainerView.addConstraints(withFormat: "V:[v0]|", views: supportButton)
		buttonsContainerView.addConstraints(withFormat: "H:[v0]|", views: createAccountButton)
		buttonsContainerView.addConstraints(withFormat: "V:[v0]|", views: createAccountButton)

	}
	
	private func configureLoginView() {
		loginView.loginTextField.delegate = self
		loginView.passwordTextField.delegate = self
		
		loginView.loginTextField.tag = 0
		loginView.passwordTextField.tag = 1
		
		loginView.bounds = CGRect(x: 0, y: 0,
		                          width: self.view.bounds.width - self.view.layoutMargins.left * 2,
		                          height: 310.0)
		loginView.center = CGPoint(x: self.view.center.x,
		                           y: self.view.center.y + self.view.bounds.height)
		view.addSubview(loginView)
		
		loginView.loginButton.layer.cornerRadius = loginView.loginButton.bounds.height / 2
		loginView.loginButton.layer.masksToBounds = true
		loginView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
		createAccountButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
	}
	func createAccount() {
		let ViewController = CreateAccountViewController()
		ViewController.modalTransitionStyle = .flipHorizontal
		present(ViewController, animated: true, completion: {UIApplication.shared.keyWindow?.rootViewController = ViewController})
	}
	func login(){
		guard let email = loginView.loginTextField.text else { return }
		guard let password = loginView.passwordTextField.text else { return }
		if isValidEmail(enteredEmail: email) && password != "" {
			
			AuthProvider.Instance.login(withEmail: email, password: password, loginHandler: { (message) in
				
				if message != nil {
					self.alertTheUser(title: "Problem With Authentication", message: message!);
				} else {
					
					
					//self.performSegue(withIdentifier: self.CONTACTS_SEGUE, sender: nil);
					
				}
				
			})
			presentTabBarController()
		}
		else {
			if isValidEmail(enteredEmail: email) == false && password == ""{
			alertTheUser(title: "Error", message: "You should enter valid email and password")
			}
			if isValidEmail(enteredEmail: email) == false && password != ""{
				alertTheUser(title: "Error", message: "You should enter email ")
			}
			if isValidEmail(enteredEmail: email) == true && password == ""{
				alertTheUser(title: "Error", message: "You should enter password ")
			}

		}
	}
	
	func presentTabBarController(){
		
		let tabBarViewController = GradientTabBarViewController()
		tabBarViewController.modalTransitionStyle = .flipHorizontal
		present(tabBarViewController, animated: true, completion: {UIApplication.shared.keyWindow?.rootViewController = tabBarViewController})
	}
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if let nextField = textField.superview?.superview?.viewWithTag(textField.tag + 1) as? UITextField {
			nextField.becomeFirstResponder()
		} else {
			textField.resignFirstResponder()
		}
		return false
	}
	
	func hideKeyboard() {
		self.view.endEditing(true)
	}
	func alertTheUser(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
		let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
		alert.addAction(ok);
		present(alert, animated: true, completion: nil);
	}
	func isValidEmail(enteredEmail: String) -> Bool {
		let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
		return emailPredicate.evaluate(with: enteredEmail)
	}
	

}

class LoginView: UIView {
	private let CONTACTS_SEGUE = "ContactsSegue";
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
		field.keyboardType = .emailAddress
		field.textColor = SharedStyleKit.calendarCellTitleColor
		field.translatesAutoresizingMaskIntoConstraints = false
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
		field.translatesAutoresizingMaskIntoConstraints = false
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
		//Shadow
		self.layer.shadowRadius = 20
		self.layer.shadowOffset = CGSize(width: 0, height: 2)
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOpacity = 0.20
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
		
		addConstraints(withFormat: "H:|-30-[v0]-30-|", views: loginView)
		addConstraints(withFormat: "H:|-30-[v0]-30-|", views: passwordView)
		addConstraints(withFormat: "H:|-30-[v0]-30-|", views: loginButton)
		
		addConstraints(withFormat: "V:[v0(34)]-25-[v1(34)]-25-[v2]", views: loginView, passwordView, loginButton)
		addConstraints(withFormat: "V:[v0(>=30,<=48)]-18-[v1]-18-|", views: loginButton, restorePasswordButton)
		passwordView.autoAlignAxis(.horizontal, toSameAxisOf: self, withOffset: -20.0)
		restorePasswordButton.autoAlignAxis(toSuperviewAxis: .vertical)
	}
}















