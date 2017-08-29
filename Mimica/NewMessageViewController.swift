//
//  NewMessageViewController.swift
//  Mimica
//
//  Created by Ян Хамутовский on 26.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit
import Firebase

class NewMessageViewController: UITableViewController {

	let cellId = "cellId"
	var users = [Contact]()
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
		fetchUser()

    }
	func fetchUser() {
		print("123")
	}
	func handleCancel() {
		dismiss(animated: true, completion: nil)
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
		
		return 5
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
		
		return cell
	}

}
