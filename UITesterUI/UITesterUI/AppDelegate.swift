//
//  AppDelegate.swift
//  UITesterUI
//
//  Created by 潘自强 on 15/8/11.
//  Copyright (c) 2015年 Holytiny. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let path = documentsDirectory()
        println(path)
        
        if let filesNames = NSFileManager.defaultManager().contentsAtPath(path) {
            
        } else {
            NSFileManager.defaultManager().createDirectoryAtPath("\(path)/卧虎藏龙", withIntermediateDirectories: false, attributes: nil, error: nil)
            NSFileManager.defaultManager().createDirectoryAtPath("\(path)/卧虎藏龙/副本", withIntermediateDirectories: false, attributes: nil, error: nil)
            NSFileManager.defaultManager().createDirectoryAtPath("\(path)/自由之战", withIntermediateDirectories: false, attributes: nil, error: nil)
            NSFileManager.defaultManager().createDirectoryAtPath("\(path)/自由之战/英雄", withIntermediateDirectories: false, attributes: nil, error: nil)
            
            NSFileManager.defaultManager().createFileAtPath("\(path)/test.lua", contents: nil, attributes: nil)
            NSFileManager.defaultManager().createFileAtPath("\(path)/卧虎藏龙/初始化.lua", contents: nil, attributes: nil)
            NSFileManager.defaultManager().createFileAtPath("\(path)/卧虎藏龙/切号.lua", contents: nil, attributes: nil)
            NSFileManager.defaultManager().createFileAtPath("\(path)/卧虎藏龙/副本/20级.lua", contents: nil, attributes: nil)
            NSFileManager.defaultManager().createFileAtPath("\(path)/卧虎藏龙/副本/30级.lua", contents: nil, attributes: nil)
            
            NSFileManager.defaultManager().createFileAtPath("\(path)/自由之战/初始化.lua", contents: nil, attributes: nil)
            NSFileManager.defaultManager().createFileAtPath("\(path)/自由之战/创建英雄.lua", contents: nil, attributes: nil)
            NSFileManager.defaultManager().createFileAtPath("\(path)/自由之战/英雄/死亡骑士.lua", contents: nil, attributes: nil)
            NSFileManager.defaultManager().createFileAtPath("\(path)/自由之战/英雄/山丘之王.lua", contents: nil, attributes: nil)
        }
        
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
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as! [String]
        
        return paths[0]
    }
}

