//
//  NavigationController.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

protocol NavigationController: UIViewController {
    func navigate(to controller: UIViewController, animated: Bool)
}

class NavigationControllerImpl: UINavigationController, NavigationController {
    
    override func viewDidLoad() {
        isNavigationBarHidden = true
    }
    
    func navigate(to controller: UIViewController, animated: Bool) {
        pushViewController(controller, animated: animated)
    }
}
