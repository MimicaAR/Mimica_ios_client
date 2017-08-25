//
//  AppDelegate.swift
//  Mimica
//
//  Created by Gleb Linnik on 03.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
	private let navigationBarHeight: CGFloat = 44.0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		//FirebaseApp.configure();
		setupGlobalAppearance();
		
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		
		let isSignUp = UserDefaults.standard.bool(forKey: "IsSignUp") //returns false on first run
		window?.rootViewController = isSignUp ? GradientTabBarViewController() : LoginViewController()
		
        return true
    }
	
	private func setupGlobalAppearance() {
		let font: UIFont = UIFont(name: "Rubik-Medium", size: 11.0)!
		UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
		
		let navigationBar = UINavigationBar.appearance()
		navigationBar.tintColor = .white
		let gradient = CAGradientLayer()
		gradient.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.statusBarFrame.width,
		                        height: UIApplication.shared.statusBarFrame.height + navigationBarHeight)
		gradient.locations = [0.0, 1.0]
		gradient.colors = [SharedStyleKit.mainGradientColor1.cgColor, SharedStyleKit.mainGradientColor2.cgColor]
		var image: UIImage? = nil
		UIGraphicsBeginImageContext(gradient.frame.size)
		if let context = UIGraphicsGetCurrentContext() {
			gradient.render(in: context)
			image = UIGraphicsGetImageFromCurrentImageContext()
		}
		UIGraphicsEndImageContext()
		navigationBar.setBackgroundImage(image, for: .default)
	}

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

