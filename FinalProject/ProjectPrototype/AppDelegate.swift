//
//  AppDelegate.swift
//  ProjectPrototype
//
//  Created by Van Simmons on 7/23/16.
//  Copyright © 2016 S65g. All rights reserved.
//

//Icons Citation

//Simulation Icon (Node)
//node by Jamie Dickinson from the Noun Project
//https://thenounproject.com/search/?q=cells&i=39526


//Instrumentation
//low gauge by romzicon from the Noun Project
//https://thenounproject.com/search/?q=instrument%20panel&i=540908


//Statistics Icon
//Graph by gayatri from the Noun Project
//https://thenounproject.com/search/?q=Statistics&i=154953


//Main Icon
//Conways Game Of Life by  Pablo Andrés Dorado Suárez from the Noun Project
//https://thenounproject.com/search/?q=conway&i=14951

//Pac-Man Audio
//http://www.classicgaming.cc/classics/pac-man/sounds

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "saveUserGridsNotification", object:nil, userInfo:nil))

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

