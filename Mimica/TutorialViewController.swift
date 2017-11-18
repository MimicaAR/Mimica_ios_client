//
//  TutorialViewController.swift
//  Mimica
//
//  Created by Gleb Linnik on 29.09.2017.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

public let TutorialViewControllerImageKey = "TutorialViewControllerImageKey"
public let TutorialViewControllerTitleKey = "TutorialViewControllerTitleKey"
public let TutorialViewControllerDescriptionKey = "TutorialViewControllerDescriptionKey"
public let TutorialViewControllerIsHasButtonKey = "TutorialViewControllerIsHasButtonKey"
public let TutorialViewControllerIsButtonTextKey = "TutorialViewControllerIsButtonTextKey"

public enum TutorialViewControllerIsHasButton: Int {
	case hidden
	case shown
}

class TutorialViewController: UIViewController {
	
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var optionalButtom: UIButton!
	
	private var _options: [String : Any]? = nil
	@objc private var _buttonTarget: (()->())? = nil
	
	var options: [String : Any]? {
		get { return _options }
		set {
			_options = newValue
			if (isViewLoaded) { configureWithOptions() }
		}
	}
	
	@objc var buttonTarget: (()->())? {
		get { return _buttonTarget }
		set {
			_buttonTarget = newValue
			if (isViewLoaded) {  }
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		bgView.layer.cornerRadius = 20.0
		bgView.layer.shadowRadius = 20.0
		bgView.layer.shadowOffset = CGSize(width: 0, height: 2)
		bgView.layer.shadowColor = UIColor.black.cgColor
		bgView.layer.shadowOpacity = 0.20
		
		optionalButtom.setTitleColor(UIColor(white: 1.0, alpha: 0.9), for: .normal)
		optionalButtom.backgroundColor = SharedStyleKit.loginButtonColor
		optionalButtom.layer.cornerRadius = optionalButtom.bounds.height / 2
		
		configureWithOptions()
    }
	
	fileprivate func configureWithOptions() {
		guard let initOptions = options else { return }
		guard !((options?.isEmpty)!) else { return }
		
		if let newImage = initOptions[TutorialViewControllerImageKey] {
			if newImage is UIImage {
				image.image = (newImage as! UIImage)
			} else if newImage is String {
				image.image = UIImage(named: newImage as! String)
			}
		}
		if let newTitle = initOptions[TutorialViewControllerTitleKey] as? String {
			titleLabel.text = newTitle
		}
		if let newDescription = initOptions[TutorialViewControllerDescriptionKey] as? String {
			descriptionLabel.text = newDescription
		}
		if let showButton = initOptions[TutorialViewControllerIsHasButtonKey]{
			let interger = showButton is TutorialViewControllerIsHasButton ?
				(showButton as! TutorialViewControllerIsHasButton).rawValue : showButton as! Int
			optionalButtom.isHidden = interger == 0
		}
		if let buttonText = initOptions[TutorialViewControllerIsButtonTextKey] as? String {
			optionalButtom.setTitle(buttonText, for: .normal)
		}
	}
	
	@IBAction func dismiss(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
}
