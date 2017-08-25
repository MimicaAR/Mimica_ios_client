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

class VideoSessionManager: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
	private let captureSession = AVCaptureSession()
	private let position = AVCaptureDevicePosition.front
	private let quality = AVCaptureSessionPresetMedium
	
	private let context = CIContext()
	
	private let sessionQueue = DispatchQueue(label: "io.mimica.mimica_ios.sessionQueue")
	private var permissionGranted = false
	
	weak var delegate: VideoSessionManagerDelegate?
	
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
		
		guard let connection = videoOutput.connection(withMediaType: AVFoundation.AVMediaTypeVideo) else { return }
		guard connection.isVideoOrientationSupported else { return }
		guard connection.isVideoMirroringSupported else { return }
		connection.videoOrientation = .portrait
		connection.isVideoMirrored = position == .front
	}
	
	private func selectCaptureDevice() -> AVCaptureDevice? {
		return AVCaptureDevice.devices().filter {
			($0 as AnyObject).hasMediaType(AVMediaTypeVideo) &&
				($0 as AnyObject).position == position
			}.first as? AVCaptureDevice
	}
	
	func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
		guard let uiImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
		DispatchQueue.main.async { [unowned self] in
			self.delegate?.captured(image: uiImage, frame: features?.first?.bounds)
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

