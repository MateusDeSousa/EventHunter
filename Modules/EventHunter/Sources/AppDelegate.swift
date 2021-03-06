//
//  AppDelegate.swift
//  EventHunter
//
//  Created by Mateus Sousa on 14/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: EventViewController(viewModel: ListEventsViewModel()))
        window?.makeKeyAndVisible()
        
        return true
    }
}

