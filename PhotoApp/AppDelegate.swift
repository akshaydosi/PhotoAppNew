///**
/*
 FileName : AppDelegate
 Description : The main entry point for the application
 Copyright : Copyright © 2018 Cognizant. All rights reserved.
 Created Date : 01/22/19
 =============================================================================
 */
import UIKit
//Test
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController: UINavigationController?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ///Since we removed the Main Storyboard : set the initial view controller as Root View
        window = UIWindow(frame: UIScreen.main.bounds)
        navController = UINavigationController()

        let vcController = PhotoCollectionViewController()

        self.navController?.pushViewController(vcController, animated: false)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }

}
