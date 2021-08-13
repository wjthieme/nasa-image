//
//  NavigationController.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import UIKit
@testable import NasaImage

class NavigationControllerMock: NavigationController {
    var controllers: [UIViewController] = []
    var currentController: UIViewController? { return controllers.last }
    func navigate(to controller: UIViewController, animated: Bool) {
        self.controllers.append(controller)
    }
    func pop(animated: Bool) {
        self.controllers.removeLast()
    }
}
