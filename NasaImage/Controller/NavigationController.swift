//
//  NavigationController.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

protocol NavigationController: AnyObject {
    func navigate(to controller: UIViewController, animated: Bool)
}

class NavigationControllerImpl: UIWindow, NavigationController {
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        rootViewController = UIViewController()
        makeKeyAndVisible()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func navigate(to controller: UIViewController, animated: Bool) {
        rootViewController = controller
        guard animated else { return }
        let animation = CATransition()
        animation.duration = 0.5
        animation.type = .fade
        layer.add(animation, forKey: kCATransition)
    }
}
