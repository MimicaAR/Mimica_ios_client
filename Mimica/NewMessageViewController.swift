//
//  NewMessageViewController.swift
//  Mimica
//
//  Created by Ян Хамутовский on 26.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class NewMessageViewController: UITableViewController {

	let cellId = "cellId"
	var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
		navigationItem.title = "New Message"
		tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
		checkUser()
		fetchUser()

    }
	func checkUser(){
		if Auth.auth().currentUser?.uid == nil {
			perform(#selector(HomeViewController.handleLogout), with: nil, afterDelay: 0)
		}
		else {
			let uid = Auth.auth().currentUser?.uid
			Database.database().reference().child("clients").child(uid!).observe(.value, with: { (snapshot) in
				if let dictionary = snapshot.value as? [String : Any] {
					self.navigationItem.title = dictionary["name"] as? String
				}
			})
		}
	}
	func fetchUser() {
		Database.database().reference().child("clients").observe(.childAdded, with: { (snapshot) in
			if let dictionary = snapshot.value as? [String: Any]{
			let user = User()
			user.setValuesForKeys(dictionary)
			self.users.append(user)
				DispatchQueue.main.async(execute: {
					self.tableView.reloadData()
				})
				
			}
		}, withCancel: nil)
	}
	func handleCancel() {
		dismiss(animated: true, completion: nil)
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
		
		return users.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
		
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
		
		let user = users[indexPath.row]
		cell.textLabel?.text = user.name
		cell.detailTextLabel?.text = user.email
		
		return cell
	}
}

class UserCell: UITableViewCell {
	override init(style: UITableViewCellStyle, reuseIdentifier: String?){
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
