//
//  DataBaseProvider.swift
//  Mimica
//
//  Created by Ян Хамутовский on 14.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

protocol FetchData: class {
	func dataReceived(contacts: [User]);
}
class DBProvider {
	private static let _instance = DBProvider()
	weak var delegate: FetchData?;
	private init() {}
	
	static var Instance: DBProvider{
		return _instance;
	}
	
	var dbRef: DatabaseReference {
		return Database.database().reference()
	}
	
	var contactsRef : DatabaseReference {
		return dbRef.child(Constants.CONTACTS)
	}
	
	var messagesRef: DatabaseReference {
		return dbRef.child(Constants.MESSAGES)
	}
	
	var mediaMessagesRef: DatabaseReference {
		return dbRef.child(Constants.MEDIA_MESSAGES)
	}
	
	var storageRef: StorageReference {
		return Storage.storage().reference(forURL: "gs://mimica-63bb5.appspot.com")	}
	
	var imageStorageRef: StorageReference{
		return storageRef.child(Constants.IMAGE_STORAGE)
	}
	func saveUser(withID: String, name: String, email: String, password: String) {
		let data: Dictionary<String, Any> = [Constants.NAME: name, Constants.EMAIL: email]
		contactsRef.child(withID).setValue(data)   

	}
//	func getContacts() {
//		
//		contactsRef.observeSingleEvent(of: DataEventType.value) {
//			(snapshot: DataSnapshot) in
//			var contacts = [Contact]();
//			
//			if let myContacts = snapshot.value as? NSDictionary {
//				
//				for (key, value) in myContacts {
//					
//					if let contactData = value as? NSDictionary {
//						
//						if let email = contactData[Constants.EMAIL] as? String {
//							
//							let id = key as! String;
//							let newContact = (id: id, name: email);
//							contacts.append(newContact);
//						}
//					}
//				}
//			}
//			self.delegate?.dataReceived(contacts: contacts);
//		}
//		
//	}

}
