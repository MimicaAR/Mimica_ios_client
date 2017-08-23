//
//  FirstViewController.swift
//  Mimica
//
//  Created by Gleb Linnik on 03.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,
	UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	private let cellId = "Date cell"
	
	var collectionView: UICollectionView? = nil
	
	
/// Appearance
	override func viewDidLoad() {
        super.viewDidLoad()
		self.setupViews()
    }
	
	private func setupViews() {
		self.view = UIView(frame: UIScreen.main.bounds)
		setupCollectionView()
		setupNavigationBar()
		setupTrainNowView()
	}
	
	private func setupCollectionView() {
		let layout = UICollectionViewFlowLayout()
		self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
		self.collectionView?.delegate = self
		self.collectionView?.dataSource = self
		self.collectionView?.register(DateCell.self, forCellWithReuseIdentifier: cellId)
		self.collectionView?.backgroundColor = SharedStyleKit.calendarCellBgColor
		self.collectionView?.bounces = true
		self.view.addSubview(self.collectionView!)
		
		let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|",
		                                                           options: [],
		                                                           metrics: nil,
		                                                           views: ["collectionView" : collectionView!])
		
		let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]|",
		                                                              options: [],
		                                                              metrics: nil,
		                                                              views: ["collectionView" : collectionView!])
		self.view.addConstraints(horizontalConstraints)
		self.view.addConstraints(verticalConstraints)
		self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func configureCellSize() -> CGSize{
		return CGSize(width: view.bounds.width - view.layoutMargins.left * 2, height: 60)
	}
	
	private func setupNavigationBar() {
		self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "mimica"))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "Profile icon"),
		                                                              style: .plain,
		                                                              target: self,
		                                                              action: nil)
	}
	
	private func setupTrainNowView() {}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
			
		guard let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
			return
		}
		
		flowLayout.itemSize = configureCellSize()
			
		flowLayout.invalidateLayout()
	}

/// UICollectionView delegates
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DateCell
		cell.dateText = "20 авг\n17:00"
		cell.titleText = "Плановое обследование в клинике"
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return configureCellSize()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
	}
}

