//
//  FirstViewController.swift
//  Mimica
//
//  Created by Gleb Linnik on 03.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var tableView: UITableView!
	override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView.init(image: UIImage.init(named: "mimica"))
    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: CalendarTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Calendar cell") as! CalendarTableViewCell
		return cell
	}
}

