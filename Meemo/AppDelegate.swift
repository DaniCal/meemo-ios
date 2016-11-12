//
//  AppDelegate.swift
//  Meemo
//
//  Created by Daniel Lohse on 9/21/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import UserNotifications
import Mixpanel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, FirebaseSynchornizeDelegate{

    var window: UIWindow?
    var navigationController: UINavigationController?
    var content:Content!

    func showWelcomeScreen(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController")
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        UserDefaults.standard.set(true, forKey: "launchedBefore")
    }
    
    func showNavigationController(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "NavigationController")
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()

    }
    
    func initFIRNotification(){
        
    }
    
    func attachNavigationController(){
        //self.window = UIWindow(frame: UIScreen.main.bounds)
        self.navigationController = window?.rootViewController as? UINavigationController
    }
    
    
    func firebaseDidLoadContent(content:Content){
        self.content = content
        showNavigationController()
    }

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if(!launchedBefore){
            showWelcomeScreen()
        }
        
        
        //Initialize Firebase Notification
        
        connectToFCM()
        
        if #available(iOS 10.0, *) {
            //options and settings for iOS 10 devices
            let authOptions : UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_,_ in })
            
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            // For iOS 10 data message (sent via FCM)
            FIRMessaging.messaging().remoteMessageDelegate = self
            
        } else {
            //TODO: Other versions than iOS 10
        }
        
        FIRApp.configure()
        
        
        let token = "4741221112f36c0d43215a2b51e12e1e"
        
        
        let mixpanel = Mixpanel.sharedInstance(withToken: token)
        mixpanel.track("App launched")
        
        
        attachNavigationController()
        FirebaseSynchronizer.delegate = self
        if(content == nil){
            FirebaseSynchronizer.subscribeToContent()
        }
        
        
        return true
    }
    
    func connectToFCM(){
        FIRMessaging.messaging().connect{(error) in
            if error != nil{
                print("Unable to concect \(error)")
            }else{
                print("Connected to FCM")
            }
        }
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

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        // Print message ID.
        print("Message ID: \(userInfo["gcm.message_id"]!)")
        
        // Print full message.
        print("%@", userInfo)
    }
}

extension AppDelegate : FIRMessagingDelegate {
    // Receive data message on iOS 10 devices.
    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        print("%@", remoteMessage.appData)
    }
}
