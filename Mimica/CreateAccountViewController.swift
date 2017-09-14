//
//  CreateAccountViewController.swift
//  Mimica
//
//  Created by Ян Хамутовский on 25.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit
import PureLayout
import Firebase
import FirebaseAuth


@available(iOS 9.0, *)
class CreateAccountViewController: UIViewController {
	private let CONTACTS_SEGUE = "ContactsSegue";
	
	let logoImage = UIImageView(image: #imageLiteral(resourceName: "Launch logo"))
	
	let inputsContainerView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.white
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 5
		view.layer.masksToBounds = true
		return view
	}()
	

	lazy var registerButton : UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("SIGN UP", for: .normal)
		button.setTitleColor(UIColor(white: 1.0, alpha: 0.9), for: .normal)
		button.setTitleColor(UIColor(white: 1.0, alpha: 0.5), for: .highlighted)
		button.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 17.0)
		button.backgroundColor = SharedStyleKit.loginButtonColor
		button.layer.cornerRadius = 24.0
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
		return button
		
	}()
	let nameTextField : UITextField = {
		let text = UITextField()
		text.font = UIFont(name: "Rubik-Regular", size: 17.0)
		text.placeholder = "Full Name"
		text.translatesAutoresizingMaskIntoConstraints = false
		return text
	}()
	
	let nameSeparatorView : UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let emailTextField : UITextField = {
		let text = UITextField()
		text.font = UIFont(name: "Rubik-Regular", size: 17.0)
		text.placeholder = "Email"
		text.translatesAutoresizingMaskIntoConstraints = false
		return text
	}()
	
	let emailSeparatorView : UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let passwordTextField : UITextField = {
		let text = UITextField()
		text.font = UIFont(name: "Rubik-Regular", size: 17.0)
		text.placeholder = "Password (at least 6 charecters)"
		text.translatesAutoresizingMaskIntoConstraints = false
		text.isSecureTextEntry = true
		return text
	}()
	func handleRegister() {
	
		typeOfError(name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
		if isValidEmail(enteredEmail: emailTextField.text!) == true {
			AuthProvider.Instance.signUp(name: nameTextField.text!, withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
				if message != nil {
					
					self.alertTheUser(title: "Problem with creating new user", message: message!)
				}
				else {
					self.emailTextField.text = ""
					self.passwordTextField.text = ""
					print("Saved user succesfully")
				}
			})
		}
		else {
			alertTheUser(title: "Error", message: "Incorrect e-mail adress, please repeat.")
			}
		
	}
	
	func typeOfError (name: String, email: String, password: String){
		if name == ""  {
			alertTheUser(title: "Error", message: "You should enter your full name.")
			return
		}
		if email == "" {
			alertTheUser(title: "Error", message: "You should enter your email adress.")
			return
		}
		if password == "" {
			alertTheUser(title: "Error", message: "You should enter your password.")
			return
		}
	}
	func isValidEmail(enteredEmail: String) -> Bool {
		let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
		return emailPredicate.evaluate(with: enteredEmail)
	}

	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureBGView()
		view.addSubview(inputsContainerView)
		view.addSubview(registerButton)
		setupInputsContainerView()
		setupRegisterButton()
		
    }
	func configureBGView() {
		view.backgroundColor = .white
		let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "Loading screen"))
		view.addSubview(backgroundImageView)
		backgroundImageView.autoPinEdgesToSuperviewEdges()
		//view.addSubview(logoImage)
	}
	
	func setupInputsContainerView(){
		
		inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
		inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
		//============================
		inputsContainerView.addSubview(nameTextField)
		inputsContainerView.addSubview(nameSeparatorView)
		inputsContainerView.addSubview(emailTextField)
		inputsContainerView.addSubview(emailSeparatorView)
		inputsContainerView.addSubview(passwordTextField)
		
		//=============================
		nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
		nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
		//======================
		nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
		nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
		nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
		//======================
		emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
		emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
		//======================
		emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
		emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
		emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
		//======================
		passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
		passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
		
		
	}
	func setupRegisterButton(){
		registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		registerButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
		registerButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		registerButton.heightAnchor.constraint(equalToConstant: 30)
		registerButton.addTarget(self, action: #selector(presentTabBarController), for: .touchUpInside)
	}
	func presentTabBarController(){
		let tabBarViewController = GradientTabBarViewController()
		tabBarViewController.modalTransitionStyle = .flipHorizontal
		present(tabBarViewController, animated: true, completion: {UIApplication.shared.keyWindow?.rootViewController = tabBarViewController})
	}
	private func alertTheUser(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
		let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
		alert.addAction(ok);
		present(alert, animated: true, completion: nil);
	}
	
}
