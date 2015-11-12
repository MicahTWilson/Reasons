//
//  AppDelegate.swift
//  Sydney's App
//
//  Created by Micah Wilson on 10/29/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        Parse.enableLocalDatastore()
        
        PFUser.enableAutomaticUser()
        
        Parse.setApplicationId("M73Vg7Scza3zACxmYld2hlfw083SyvcuzUkYTQbn", clientKey: "Z3eoysNJQ556BowA8BiEdIrpWq6cKQeovTx7ONBR")
        
        let defaultACL = PFACL();
        
        // If you would like all objects to be private by default, remove this line.
        defaultACL.setPublicReadAccess(true)
        
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser:true)
        
        if application.applicationState != UIApplicationState.Background {
            // Track an app open here if we launch with a push, unless
            // "content_available" was used to trigger a background push (introduced in iOS 7).
            // In that case, we skip tracking here to avoid double counting the app-open.
            
            let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
            let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
            var noPushPayload = false;
            if let options = launchOptions {
                noPushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil;
            }
            if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
            }
        }
        
        let tabBarController = self.window?.rootViewController as! UITabBarController
        let tabBar = tabBarController.tabBar
        
        let reasonsTab = tabBar.items![0]
        reasonsTab.image = UIImage(named: "HeartIcon")?.imageWithRenderingMode(.AlwaysOriginal)
        reasonsTab.selectedImage = UIImage(named: "HeartIconSelected")?.imageWithRenderingMode(.AlwaysOriginal)
        
        let pathTab = tabBar.items![1]
        pathTab.image = UIImage(named: "PathIcon")?.imageWithRenderingMode(.AlwaysOriginal)
        pathTab.selectedImage = UIImage(named: "PathIconSelected")?.imageWithRenderingMode(.AlwaysOriginal)
        
        let bucketListTab = tabBar.items![2]
        bucketListTab.image = UIImage(named: "BucketIcon")?.imageWithRenderingMode(.AlwaysOriginal)
        bucketListTab.selectedImage = UIImage(named: "BucketIconSelected")?.imageWithRenderingMode(.AlwaysOriginal)
        
        let countdownTab = tabBar.items![3]
        countdownTab.image = UIImage(named: "ClockIcon")?.imageWithRenderingMode(.AlwaysOriginal)
        countdownTab.selectedImage = UIImage(named: "ClockIconSelected")?.imageWithRenderingMode(.AlwaysOriginal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:0.65, green:0.95, blue:0.95, alpha:1)], forState: .Selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

