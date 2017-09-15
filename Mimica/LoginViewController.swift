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
	let bottomContainerView = UIView()
	let socialMediaButtons = SocialMediaLoginView()

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
										NSLayoutConstraint.autoSetPriority(UILayoutPriorityDefaultHigh, forConstraints: { self.loginView.autoAlignAxis(toSuperviewAxis: .horizontal) })
										self.loginView.autoPinEdge(toSuperviewMargin: .left)
										self.loginView.autoPinEdge(toSuperviewMargin: .right)
										self.view.addConstraints(withFormat: "V:[v0(310)]",
										                         views: self.loginView)
										self.view.layoutIfNeeded()
										self.loginView.loginButton.layer.cornerRadius = self.loginView.loginButton.frame.height / 2
										UIView.animate(withDuration: 0.5,
										               delay: 0.3,
										               options: .curveEaseOut,
										               animations: {
														self.bottomView.autoPinEdge(toSuperviewEdge: .left)
														self.bottomView.autoPinEdge(toSuperviewEdge: .right)
														self.self.bottomView.autoPinEdge(toSuperviewEdge: .bottom)
														self.bottomView.addConstraints(withFormat: "V:[v0(\(self.view.bounds.height / 2))]", views: self.bottomView)
														// Social buttons
														self.view.addConstraints(withFormat: "V:[v0]-[v1(>=138)]|", views: self.loginView, self.bottomContainerView)
														self.bottomContainerView.autoPinEdge(toSuperviewMargin: .left)
														self.bottomContainerView.autoPinEdge(toSuperviewMargin: .right)
														self.view.layoutIfNeeded()
										},
										               completion: nil)
						},
						               completion: nil)
		})
	}
	
	private func setupViews() {
		configureBGView()
		configureLogo()
		configureBottomView()
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
	
	private func configureLoginView() {
		view.addSubview(loginView)
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
		socialMediaButtons.createAccountButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
	}
	
	private func configureBottomView() {
		view.addSubview(bottomView)
		bottomView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: view.bounds.height / 2)
		view.addSubview(bottomContainerView)
		bottomContainerView.addSubview(socialMediaButtons)
		socialMediaButtons.autoAlignAxis(toSuperviewAxis: .horizontal)
		socialMediaButtons.autoPinEdge(toSuperviewEdge: .left)
		socialMediaButtons.autoPinEdge(toSuperviewEdge: .right)
		bottomContainerView.addConstraints(withFormat: "V:[v0(139)]", views: socialMediaButtons)
		bottomContainerView.frame = CGRect(origin: CGPoint(x: 0, y: view.bounds.height), size: CGSize(width: view.bounds.width, height: 138))
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
					
				}
				
			})
			presentTabBarController()
		} else {
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
	
	private func presentTabBarController(){
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
	
	@objc private func hideKeyboard() {
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





