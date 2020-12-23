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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSPlacesClient.provideAPIKey("AIzaSyCxFYdxbLTkwdNRdcdl-SgXMbrRz6Bh-_Y")
        GMSServices.provideAPIKey("AIzaSyCOI1dZ7uUIaOvzlr5C4T2ki6AnMpkh2tc")
        func printFonts() {
            for familyName in UIFont.familyNames {
                print("\n-- \(familyName) \n")
                for fontName in UIFont.fontNames(forFamilyName: familyName) {
                    print(fontName)
                }
            }
        }
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
    
}

