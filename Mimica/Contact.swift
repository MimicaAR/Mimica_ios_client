//
//  Contact.swift
//  Mimica
//
//  Created by Ян Хамутовский on 24.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import Foundation

class Contact {
	private var _name = ""
	private var _id = ""
	
	
	init(id: String,name: String) {
		_id = id
		_name = name
	
	}
	
	var name: String {
		get {
			return _name
		}
	}
	var id: String {
		return _id
	}

}

