//
//  VideoSessionManager.swift
//  Mimica
//
//  Created by Gleb Linnik on 24.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit
import AVFoundation

protocol VideoSessionManagerDelegate: class {
	func captured(image: UIImage)
}

class VideoSessionManager: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureMetadataOutputObjectsDelegate {
	private let captureSession = AVCaptureSession()
	private let position = AVCaptureDevicePosition.front
	private let quality = AVCaptureSessionPreset1280x720
	
	private let context = CIContext()
	
	 let sessionQueue = DispatchQueue(label: "io.mimica.mimica_ios.sessionQueue")
	private var permissionGranted = false
	
	private var currentMetadata: [AnyObject] = []
	
	weak var delegate: VideoSessionManagerDelegate?
	let layer = AVSampleBufferDisplayLayer()
	
	override init() {
		super.init()
		checkPermission()
		sessionQueue.async { [unowned self] in
			self.configureSession()
			self.captureSession.startRunning()
		}
	}
	
	// MARK: AVSession configuration
	private func checkPermission() {
		switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
		case .authorized:
			permissionGranted = true
		case .notDetermined:
			requestPermission()
		default:
			permissionGranted = false
		}
	}
	
	private func requestPermission() {
		sessionQueue.suspend()
		AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { [unowned self] granted in
			self.permissionGranted = granted
			self.sessionQueue.resume()
		}
	}
	
	private func configureSession() {
		guard permissionGranted else { return }
		captureSession.sessionPreset = quality
		
		guard let captureDevice = selectCaptureDevice() else { return }
		guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice) else { return }
		guard captureSession.canAddInput(captureDeviceInput) else { return }
		captureSession.addInput(captureDeviceInput)
		
		let videoOutput = AVCaptureVideoDataOutput()
		videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "io.mimica.mimica_ios.sampleBuffer"))
		guard captureSession.canAddOutput(videoOutput) else { return }
		captureSession.addOutput(videoOutput)
		
		let metaOutput = AVCaptureMetadataOutput()
		metaOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue(label: "io.mimica.mimica_ios.faceQueue"))
		guard captureSession.canAddOutput(metaOutput) else { return }
		captureSession.addOutput(metaOutput)
		metaOutput.metadataObjectTypes = [AVMetadataObjectTypeFace]
		
		guard let connection = videoOutput.connection(withMediaType: AVFoundation.AVMediaTypeVideo) else { return }
		guard connection.isVideoOrientationSupported else { return }
		guard connection.isVideoMirroringSupported else { return }
		// TODO: Make for all configurations
		connection.videoOrientation = .portrait
		connection.isVideoMirrored = position == .front
	}
	
	private func selectCaptureDevice() -> AVCaptureDevice? {
		return AVCaptureDevice.devices().filter {
			($0 as AnyObject).hasMediaType(AVMediaTypeVideo) &&
				($0 as AnyObject).position == position
			}.first as? AVCaptureDevice
	}
	
	// MARK: AVCaptureVideoDataOutputSampleBufferDelegate
	
	func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
		guard let uiImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
		DispatchQueue.main.async { [unowned self] in
			self.delegate?.captured(image: uiImage)
			self.layer.enqueue(sampleBuffer)
		}
		print(layer.bounds)
	}
	
	// MARK: AVCaptureMetadataOutputObjectsDelegate
	
	func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
		for metadataObject in metadataObjects as! [AVMetadataObject] {
			if metadataObject.type == AVMetadataObjectTypeFace {
				let faceMetaObject = metadataObject as! AVMetadataFaceObject
				print("ID: \(faceMetaObject.faceID)")
				print("Bounds: \(faceMetaObject.bounds)")
				print("Roll Angle: \(faceMetaObject.rollAngle)")
				print("Yaw Angle: \(faceMetaObject.yawAngle)")
			}
		}
	}
	
	private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage? {
		guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
		let ciImage = CIImage(cvPixelBuffer: imageBuffer)
		let context = CIContext()
		guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
		return UIImage(cgImage: cgImage)
	}
}

