//
//  CreateAccountViewController.swift
//  Mimica
//
//  Created by Ян Хамутовский on 25.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

@available(iOS 9.0, *)
class CreateAccountViewController: UIViewController {
	
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
		button.backgroundColor = UIColor.black
		button.setTitle("Register", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 5
		button.setTitleColor(UIColor.white, for: .normal)
		button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
		return button
		
	}()
		let nameTextField : UITextField = {
		let text = UITextField()
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
		text.placeholder = "Password"
		text.translatesAutoresizingMaskIntoConstraints = false
		text.isSecureTextEntry = true
		return text
	}()
	func handleRegister() {
		
		Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (FIRUser, error) in
			if error != nil {
				print(error!)
				return
			}
			guard let uid = FIRUser?.uid else {
				return
			}
			//success
			let ref = Database.database().reference(fromURL: "https://mimica-63bb5.firebaseio.com/")
			let userReference = ref.child("clients").child(uid)
			let values = ["Full name": self.nameTextField.text, "Email": self.emailTextField.text, "Password": self.passwordTextField.text]
			userReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
				
				if err != nil {
					print(err!)
					return
				}
				print("Saved user succesfully")
			})
		}
	}
	

	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = UIColor.blue
		
		view.addSubview(inputsContainerView)
		view.addSubview(registerButton)
		
		setupInputsContainerView()
		setupRegisterButton()
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
	}
}
