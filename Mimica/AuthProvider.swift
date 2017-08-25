//
//  AuthProvider.swift
//  Mimica
//
//  Created by Ян Хамутовский on 24.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import Foundation
import FirebaseAuth

/*typealias LoginHandler = (_ msg: String?) -> Void
struct LoginErrorCode {
	static let INVALID_EMAIL = "Invalid Email adress, please provide a real Email adress"
	static let WRONG_PASSWORD = "Wrong password, please repeat"
	static let PROBLEM_CONNECTING = "Sorry, you have problems of connecting to our server, please try again"
	static let USER_NOT_FOUND = "User not found, please, register"
	static let EMAIL_ALREDY_IN_USE = "Email already in use, please use another Email adress"
	static let WEAK_PASSWORD = "Password should be at least 6 characters long"
}

class AuthProvider {
	private static let _instance = AuthProvider()
	
	static var Instance: AuthProvider {
		return _instance
	}
	var userName = "";
	
	func login(withEmail: String, password: String, loginHandler: LoginHandler?) {
		
		Auth.auth().signIn(withEmail: withEmail, password: password, completion: { (user, error) in
			
			
			if error != nil {
				self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
			}
			else {
				loginHandler?(nil)
			}
		})
	}//login function-------------
	

	func signUp(withEmail: String, password: String, loginHandler: LoginHandler?) {
		
		Auth.auth().createUser(withEmail: withEmail, password: password, completion: { (user, error) in
			
			if error != nil {
				self.handleErrors(err: error! as NSError, loginHandler: loginHandler);
			} else {
				
				if user?.uid != nil {
					
					// store the user to database
					DBProvider.Instance.saveUser(withID: user!.uid, email: withEmail, password: password);
					
					// login the user
					self.login(withEmail: withEmail, password: password, loginHandler: loginHandler);
					
				}
				
			}
			
		});
		
	} // sign up func
	
	func isLoggedIn() -> Bool {
		if Auth.auth().currentUser != nil {
			return true;
		}
		
		return false;
	}
	
	func logOut() -> Bool {
		if Auth.auth().currentUser != nil {
			do {
				try Auth.auth().signOut();
				return true;
			} catch {
				return false;
			}
		}
		return true;
	}
	
	func userID() -> String {
		return Auth.auth().currentUser!.uid;
	}
	
	/*private func handleErrors(err: NSError, loginHandler: LoginHandler?) {
		
		if let errCode = AuthErrorCode(rawValue: err.code) {
			
			switch errCode {
				
			case .errorCodeWrongPassword:
				loginHandler?(LoginErrorCode.WRONG_PASSWORD);
				break;
				
			case .errorCodeInvalidEmail:
				loginHandler?(LoginErrorCode.INVALID_EMAIL);
				break;
				
			case .errorCodeUserNotFound:
				loginHandler?(LoginErrorCode.USER_NOT_FOUND);
				break;
				
			case .errorCodeEmailAlreadyInUse:
				loginHandler?(LoginErrorCode.EMAIL_ALREADY_IN_USE);
				break;
				
			case .errorCodeWeakPassword:
				loginHandler?(LoginErrorCode.WEAK_PASSWORD);
				break;
				
			default:
				loginHandler?(LoginErrorCode.PROBLEM_CONNECTING);
				break;
				
			}
			
		}
		
	}*/

}*/


