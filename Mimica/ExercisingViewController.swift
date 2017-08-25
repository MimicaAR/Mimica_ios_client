//
//  ExercisingViewController.swift
//  Mimica
//
//  Created by Gleb Linnik on 23.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit
import AVFoundation

class ExercisingViewController: UIViewController, VideoSessionManagerDelegate {

	var videoManager: VideoSessionManager!
	let imageView = UIImageView()
	let boundView = UIView()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view = UIView(frame: UIScreen.main.bounds)
		view.addSubview(imageView)
		view.addSubview(boundView)
		boundView.layer.borderWidth = 2.0
		boundView.layer.borderColor = UIColor.yellow.cgColor
		
		imageView.contentMode = .scaleAspectFill
		imageView.autoPinEdgesToSuperviewEdges()
		videoManager = VideoSessionManager()
		videoManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func captured(image: UIImage) {
		imageView.image = image
	}
	
}

