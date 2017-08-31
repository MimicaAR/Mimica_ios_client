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
	func foundBounds(bounds: CGRect)
}

class VideoSessionManager: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureMetadataOutputObjectsDelegate {
	private let captureSession = AVCaptureSession()
	private let position = AVCaptureDevicePosition.front
	private let quality = AVCaptureSessionPresetMedium
	
	private let context = CIContext()
	
	let sessionQueue = DispatchQueue(label: "io.mimica.mimica_ios.sessionQueue")
	private var permissionGranted = false
	
	private var currentMetadata: [AnyObject] = []
	
	weak var delegate: VideoSessionManagerDelegate?
	let layer = AVCaptureVideoPreviewLayer()
	
	override init() {
		super.init()
		checkPermission()
		sessionQueue.async { [unowned self] in
			self.configureSession()
			self.captureSession.startRunning()
			// FIXME: HERE STARTS WRAPPER
			DlibWrapperManager.sharedInstance()
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
		layer.session = captureSession
		layer.videoGravity = AVLayerVideoGravityResizeAspectFill
	}
	
	private func selectCaptureDevice() -> AVCaptureDevice? {
		return AVCaptureDevice.devices().filter {
			($0 as AnyObject).hasMediaType(AVMediaTypeVideo) &&
				($0 as AnyObject).position == position
			}.first as? AVCaptureDevice
	}
	
	// MARK: AVCaptureVideoDataOutputSampleBufferDelegate
	
	func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
		guard !currentMetadata.isEmpty else { return }
		let biggestFaceMetadataObject = (currentMetadata as! [AVMetadataObject])
			.flatMap { $0 as? AVMetadataFaceObject }
			.max { (first: AVMetadataObject, second: AVMetadataObject) -> Bool in
				return first.bounds.width > second.bounds.width
		}
		if let faceMetaObject = biggestFaceMetadataObject {
			//Converting coordinated for capture connection
			var connectionConvertedBounds = captureOutput.transformedMetadataObject(for: faceMetaObject, connection: connection).bounds
			var height = (connectionConvertedBounds.width * faceMetaObject.bounds.height) / faceMetaObject.bounds.width
			var diff = height - connectionConvertedBounds.height
			connectionConvertedBounds.size.height = height
			connectionConvertedBounds.origin.y -= diff
			DlibWrapperManager.sharedInstance().findFaceLandmarks(in: sampleBuffer, inRect: NSValue(cgRect: connectionConvertedBounds))
			print("connectionConvertedBounds: \(connectionConvertedBounds)")
			//Converting coordinates for layer
			var layerConvertedBounds = self.layer.rectForMetadataOutputRect(ofInterest: faceMetaObject.bounds)
			height = (layerConvertedBounds.width * faceMetaObject.bounds.height) / faceMetaObject.bounds.width
			diff = height - layerConvertedBounds.height
			layerConvertedBounds.size.height = height
			layerConvertedBounds.origin.y -= diff
			print("layerConvertedBounds: \(layerConvertedBounds)")
			DispatchQueue.main.async { [unowned self] in
				self.delegate?.foundBounds(bounds: layerConvertedBounds)
			}
		}
	}
	
//	func captureOutput(_ captureOutput: AVCaptureOutput!, didDrop sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
//		print("DidDropSampleBuffer")
//	}
	
	// MARK: AVCaptureMetadataOutputObjectsDelegate
	
	func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
		currentMetadata = metadataObjects! as [AnyObject]
	}
	
	private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage? {
		guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
		let ciImage = CIImage(cvPixelBuffer: imageBuffer)
		let context = CIContext()
		guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
		return UIImage(cgImage: cgImage)
	}
}

