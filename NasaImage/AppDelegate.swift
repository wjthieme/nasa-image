//
//  AppDelegate.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    internal var window: UIWindow?
    internal var coordinator: ViewCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if unitTesting {
            return false
        }

        coordinator = ViewCoordinatorImpl()
        coordinator?.overview()
        
        return true
    }
    
    private var unitTesting: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }


}

