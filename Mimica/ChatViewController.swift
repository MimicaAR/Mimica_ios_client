//
//  ChatViewController.swift
//  Mimica
//
//  Created by Ян Хамутовский on 26.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(handleNewMessage))
		setupInputComponents()
    }
	
	func handleNewMessage() {
		let newMessageController = NewMessageViewController()
		let navController = UINavigationController(rootViewController: newMessageController)
		present(navController, animated: true, completion: nil)
	}
	func setupInputComponents(){
		let containerView = UIView()
		containerView.backgroundColor = UIColor.red
		containerView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(containerView)
		
		containerView.autoPinEdgesToSuperviewEdges()
	}
}


