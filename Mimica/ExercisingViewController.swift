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
	let boundView = UIView()
	let previewView = UIView()
	var lV = [UIView]()
    override func viewDidLoad() {
        super.viewDidLoad()
		view = UIView(frame: UIScreen.main.bounds)
		
		videoManager = VideoSessionManager()
		videoManager.delegate = self
		
		view.addSubview(previewView)
		previewView.frame = view.frame
		previewView.autoPinEdgesToSuperviewEdges()
		previewView.layer.addSublayer(videoManager.layer)
		videoManager.layer.frame = previewView.bounds

		previewView.addSubview(boundView)
		boundView.layer.borderWidth = 2.0
		boundView.layer.borderColor = UIColor.yellow.cgColor
		boundView.layer.cornerRadius = 5
		
		for _ in 0...67 {
			let pView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
			pView.backgroundColor = .red
			view.addSubview(pView)
			lV.append(pView)
		}

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func foundBounds(bounds: CGRect, landmarks: [CGPoint]) {
		UIView.animate(withDuration: 0.1, animations: {self.boundView.frame = bounds})
		for index in 0..<landmarks.count {
			lV[index].center = landmarks[index]
		}
	}
	
}

