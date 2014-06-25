//
//  AppDelegate.swift
//  TestHttp
//
//  Created by Jason Li on 6/25/14.
//  Copyright (c) 2014 Swiftist. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        
        
        //请求金山词霸API获取单词`swift`的解释
        var word = "swift"
        var request = HTTPTask()
        var params: Dictionary<String, AnyObject> = ["w": word, "key": "30CBA9DDD34B16DB669A9B214C941F14", "type": "json"]
        request.GET("http://dict-co.iciba.com/api/dictionary.php", parameters: params, success: {(response: AnyObject?) -> Void in
            
            //转换成JSON数据
            let json = JSONValue(response!)
            
            //得到JSON中第一个解释
            let meaning = json["symbols"][0]["parts"][0]["means"]
            
            dispatch_async(dispatch_get_main_queue(), {
                
                //注意，`SwiftHTTP`回调中如果要操作UI，必须先用gcd切换到主线程
                let alert = UIAlertView()
                alert.title = word
                alert.message = meaning.description
                alert.addButtonWithTitle("确定")
                alert.show()
                
            })
            
            println("\(json)")
            
            },failure: {(error: NSError) -> Void in
                
                println("\(error)")
            })

        
        
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

