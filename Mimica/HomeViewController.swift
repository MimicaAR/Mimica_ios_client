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
    @IBOutlet weak var trainNowView: UIView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView.init(image: UIImage.init(named: "mimica"))
		self.presentingViewController?.presentingViewController?.view.addSubview(trainNowView)
		self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "Profile icon"),
		                                                              style: .plain,
		                                                              target: self,
		                                                              action: #selector(showProfile))
    }
	
    @IBAction func showTrainigView(_ gestureRecognizer: UISwipeGestureRecognizer) {
		let stopPoint = self.view.bounds.height - (self.tabBarController?.tabBar.bounds.height)!
		let trainNowViewBottomPoint = self.trainNowView.frame.origin.y + self.trainNowView.bounds.height
		let bounceNumber: CGFloat = 10.0
		if gestureRecognizer.direction == .down && stopPoint ==
			trainNowViewBottomPoint{
			UIView.animate(withDuration: 0.3, delay: 0.0,
			               options: .curveEaseInOut,
			               animations: {
							self.trainNowView.center.y += (self.trainNowView.viewWithTag(1)?.bounds.height)!
							self.trainNowView.center.y += bounceNumber
							self.trainNowView.bounds = CGRect(x: 0, y: 0,
							                                  width: (self.trainNowView.superview?.bounds.width)!,
							                                  height: self.trainNowView.bounds.height)
			},
			               completion: {(_ :Bool) -> Void in UIView.animate(withDuration: 0.1, animations: {self.trainNowView.center.y -= bounceNumber})}
			)
		} else if gestureRecognizer.direction == .up && stopPoint < trainNowViewBottomPoint {
			UIView.animate(withDuration: 0.3, delay: 0.0,
			               options: .curveEaseInOut,
			               animations: {
							self.trainNowView.center.y -= (self.trainNowView.viewWithTag(1)?.bounds.height)!
							self.trainNowView.bounds = CGRect(x: 0, y: 0,
							                                  width: (self.trainNowView.superview?.bounds.width)! -
																((self.tableView.superview?.layoutMargins.left)! - 10) * 2,
							                                  height: self.trainNowView.bounds.height)
			},
			               completion: nil
			)
		}
    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: CalendarTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Calendar cell") as! CalendarTableViewCell
		return cell
	}
	
	func showProfile() {
		performSegue(withIdentifier: "Show profile", sender: self)
	}
}

