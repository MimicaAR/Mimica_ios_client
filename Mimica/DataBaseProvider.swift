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

class DBProvider {
	private static let _instance = DBProvider()
	
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
		return Storage.storage().reference(forURL: "gs://mimica-63bb5.appspot.com")
	}
	
	var imageStorageRef: StorageReference{
		return storageRef.child(Constants.IMAGE_STORAGE)
	}
	/*func saveUser(withID: String, email: String, password: String) {
		let data: Dictionary<String, Any> = [Constants.EMAIL: email, Constants.PASSWORD: password]
		contactsRef.child(withID).setValue(data)
	
	}*/
}
