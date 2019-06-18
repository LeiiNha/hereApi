//
//  AppDelegate.swift
//  hereApi
//
//  Created by Erica Geraldes on 15/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit
import MapKit
import NMAKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.locationManager.requestAlwaysAuthorization()

        NMAApplicationContext.set(appId: "STcFNMxGs5WeszuSC777", appCode: "1AxMuqK22Wo5DjvjjrWYSw")

        self.locationManager.requestWhenInUseAuthorization()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainViewModel = MainViewModel()
        let rootViewController = ViewController(viewModel: mainViewModel)
        let initialViewController = UINavigationController(rootViewController: rootViewController)

        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        return true
    }
}
