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
		let noseTop = 27
		let rightLipsEdge = 54
		let leftLipsEdge = 48
		let chinCenter = 8
//		UIView.animate(withDuration: 0.1, animations: {self.boundView.frame = bounds})
//		for index in 0..<landmarks.count {
//			lV[index].center = landmarks[index]
//		}
		let nosePoint = landmarks[noseTop]
		let rightLipsPoint = landmarks[rightLipsEdge]
		let leftLipsPoint = landmarks[rightLipsEdge]
		let chinPoint = landmarks[chinCenter]
		
		let a = nosePoint.x
		let b = chinPoint.x
		let c = rightLipsPoint.x
		let d = nosePoint.y
		let e = chinPoint.y
		let f = rightLipsPoint.y
		
		let x = (a*a*c - 2*a*b*c - 2*a*d*e + 2*a*d*f + 2*a*a*e - 2*a*e*f + b*b*c + 2*b*d*d - 2*b*d*e - 2*b*d*f + 2*b*e*f - c*d*d + 2*c*d*e - c*e*e) / (pow(a-b, 2) + pow(d-e, 2))
		let y = f
		lV[0].center = CGPoint(x: x, y: y)
	}
	
	func convertToNewCoordinteSystem(coordinates: [CGPoint], withAngle angle: CGFloat) -> [CGPoint] {
		var newCoordinates = [CGPoint]()
		for point in coordinates {
			let x = point.x * cos(angle) + point.y * sin(angle)
			let y = point.x * sin(angle) - point.y * cos(angle)
			let newPoint = CGPoint(x: x, y: y)
			newCoordinates.append(newPoint)
		}
		return newCoordinates
	}
}

