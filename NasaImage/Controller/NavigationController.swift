//
//  NavigationController.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

protocol NavigationController: AnyObject {
    func navigate(to controller: UIViewController, animated: Bool)
    func pop(animated: Bool)
}

class NavigationControllerImpl: UIWindow, NavigationController {
    
    let navigationController = UINavigationController()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        rootViewController = navigationController
        makeKeyAndVisible()
        
        navigationController.isNavigationBarHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func navigate(to controller: UIViewController, animated: Bool) {
        navigationController.pushViewController(controller, animated: true)
    }
    
    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
}
