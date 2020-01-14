//
//  TimeCalculator
//
//  Created by summer on 2020/1/14.
//  Copyright © 2020 Bob Development. All rights reserved.
//

import UIKit

let appKey = "2405100d63dd31a06c6dcb81"
let channel = "Publish channel"
let isProduction = true

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,JPUSHRegisterDelegate {
    func jpushNotificationAuthorization(_ status: JPAuthorizationStatus, withInfo info: [AnyHashable : Any]!) {
        
    }
    

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let entity = JPUSHRegisterEntity()
        entity.types = NSInteger(UNAuthorizationOptions.alert.rawValue) |
            NSInteger(UNAuthorizationOptions.sound.rawValue) |
            NSInteger(UNAuthorizationOptions.badge.rawValue)
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        JPUSHService.setup(withOption: launchOptions, appKey: appKey, channel: channel, apsForProduction: isProduction)
        _ = NotificationCenter.default
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        let HomeVC = MathViewController()
//        let navVC = UINavigationController()
//        navVC.viewControllers = [HomeVC]
//        navVC.navigationBar.isTranslucent = false
//        navVC.navigationBar.tintColor = styles.topViewBackgroundColor
//        let textAttributes = [NSAttributedString.Key.foregroundColor: styles.topViewBackgroundColor]
//        navVC.navigationBar.titleTextAttributes = textAttributes
        
        window?.rootViewController = HomeVC
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
     }
     @available(iOS 10.0, *)
     func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
     }
     @available(iOS 10.0, *)
     func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
     }
     func application(_ application: UIApplication,
                      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
         print("get the deviceToken  \(deviceToken)")
         JPUSHService.registerDeviceToken(deviceToken)
     }

}

