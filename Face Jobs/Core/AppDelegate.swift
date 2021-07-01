//
//  AppDelegate.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 5/1/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MOLH
import SideMenu
import IQKeyboardManagerSwift
import UserNotifications
import Firebase
import FirebaseMessaging
import Braintree
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MOLHResetable, UNUserNotificationCenterDelegate, MessagingDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        MOLH.shared.activate(true)
        BTAppSwitch.setReturnURLScheme("com.pixelCcompany.faceJobs.payments")
        IQKeyboardManager.shared.enable = true
        GMSPlacesClient.provideAPIKey("AIzaSyCxFYdxbLTkwdNRdcdl-SgXMbrRz6Bh-_Y")
        GMSServices.provideAPIKey("AIzaSyCOI1dZ7uUIaOvzlr5C4T2ki6AnMpkh2tc")
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        registerForPushNotifications()
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound], completionHandler: {(granted, error) in
        })
        application.registerForRemoteNotifications()
        UNUserNotificationCenter.current().delegate = self
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        return true
    }
  

    func reset() {
        let vc = Share.storyBoard.instantiateViewController(withIdentifier: "HomeSecreen")
        window = UIWindow()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        print("vv")
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
    
}


extension AppDelegate {
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs registration failed: \(error)")
        print("failed")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let aps = userInfo["aps"] as? [String: Any]
        let badge_number = aps?["badge"] as? Int
        let state = application.applicationState
            switch state {
                
            case .inactive:
                print("Inactive")
                
            case .background:
                print("Background")
                application.applicationIconBadgeNumber = badge_number ?? 0
                
            case .active:
                print("Active")

            @unknown default:
                print("errror")
            }
       
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
//        vc.modalPresentationStyle = .fullScreen
//        (UIApplication.shared.keyWindow?.rootViewController as? UINavigationController)?.pushViewController(vc, animated: true)
//        completionHandler()

    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
           // Print message ID.
           if let messageID = userInfo["gcmMessageIDKey"] {
               print("Message ID in UNUserNotificationCenterDelegate: \(messageID)")
           }
           completionHandler([.alert, .badge, .sound])
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        FirebaseMessaging.Messaging.messaging().token { (token, error) in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
                }
            else if let token = token {
                  print("FCM registration token: \(token)")
                UserDefaults.standard.set(token, forKey: "Firebase_TOKEN")
                }
            }
        Messaging.messaging().apnsToken = deviceToken as Data

    }
    func registerForPushNotifications() {
        //1
        UNUserNotificationCenter.current()
            .requestAuthorization(
                options: [.alert, .sound, .badge]) { [weak self] granted, _ in
                guard granted else { return }
                self?.getNotificationSettings()
            }

    }
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            switch settings.soundSetting {
            case .enabled:
                print("enabled sound")
            case .disabled:
                print("not allowed notifications")

            case .notSupported:
                print("something went wrong here")
            @unknown default:
                fatalError()
            }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }

        }
}
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        URLContexts.forEach { context in
            if context.url.scheme?.localizedCaseInsensitiveCompare("com.pixelCcompany.faceJobs.payments") == .orderedSame {
                BTAppSwitch.handleOpenURLContext(context)
            }
        }
    }
}
