//
//  FirstViewController.swift
//  Mimica
//
//  Created by Gleb Linnik on 03.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView.init(image: UIImage.init(named: "mimica"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

