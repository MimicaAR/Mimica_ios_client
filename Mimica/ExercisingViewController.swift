//
//  ExercisingViewController.swift
//  Mimica
//
//  Created by Gleb Linnik on 23.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit
import AVFoundation

class ExercisingViewController: UIViewController {

	var videoManager: VideoSessionManager!
	let boundView = UIView()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view = UIView(frame: UIScreen.main.bounds)
		view.addSubview(boundView)
		boundView.layer.borderWidth = 2.0
		boundView.layer.borderColor = UIColor.yellow.cgColor
		
		videoManager = VideoSessionManager()
		
		view.layer.addSublayer(videoManager.layer)
		videoManager.layer.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
}

