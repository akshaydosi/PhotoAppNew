///**
/*
 FileName : AppDelegate
 Description : The main entry point for the application
 Copyright : Copyright © 2018 Cognizant. All rights reserved.
 Created Date : 01/22/19
 =============================================================================
 */
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ///Since we removed the Main Storyboard : set the initial view controller as Root View
        
        print("******ENTERED didFinishLaunchingWithOptions******")

        /*window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        ///To avoid a crash : we are setting the root view via code to default viewcontroller
        let defaultFlow = UICollectionViewFlowLayout()
        let customCollectionVC = PhotoCollectionCollectionViewController(collectionViewLayout:defaultFlow)
        window?.rootViewController = customCollectionVC*/
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        navController = UINavigationController()
        let defaultFlow = UICollectionViewFlowLayout()
        let customCollectionVC = PhotoCollectionCollectionViewController(collectionViewLayout:defaultFlow)

        
        self.navController!.pushViewController(customCollectionVC, animated: false)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
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

