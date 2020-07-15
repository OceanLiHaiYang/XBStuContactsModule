//
//  AppDelegate.swift
//  XBFlutterModule
//
//  Created by henrylee_2020 on 06/19/2020.
//  Copyright (c) 2020 henrylee_2020. All rights reserved.
//

import UIKit
import Flutter
import FlutterPluginRegistrant
import flutter_boost

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    var flutterEngine: FlutterEngine?
    
//    var router: p
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let router = FlutterRouter()
//        FlutterBoostPlugin.sharedInstance().startFlutter(with: router) { (flutterEngin) in
//
//
//        }
        self.flutterEngine = FlutterEngine(name: "io.flutter", project: nil);
        self.flutterEngine?.run(withEntrypoint: nil);
        GeneratedPluginRegistrant.register(with: self.flutterEngine!);
        // Override point for customization after application launch.
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }

    override func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    override func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    override func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    override func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    override func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

