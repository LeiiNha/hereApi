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
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.locationManager.requestAlwaysAuthorization()
        
        let kHelloMapAppID = "STcFNMxGs5WeszuSC777"
        let kHelloMapAppCode = "1AxMuqK22Wo5DjvjjrWYSw"
        
        NMAApplicationContext.set(appId: kHelloMapAppID, appCode: kHelloMapAppCode)

        self.locationManager.requestWhenInUseAuthorization()
        return true
    }
}
