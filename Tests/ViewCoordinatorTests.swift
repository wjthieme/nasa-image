//
//  CoordinatorTests.swift
//  Tests
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import XCTest
@testable import NasaImage

class ViewCoordinatorTests: XCTestCase {
    
    func testCoordinatorInitialState() {
        let mockNavigation = NavigationControllerMock()
        let coordinator = ViewCoordinatorImpl()
        coordinator.navigationController = mockNavigation
        XCTAssertNil(mockNavigation.currentController)
    }
    
    func testCoordinatorOverview() {
        let mockNavigation = NavigationControllerMock()
        let coordinator = ViewCoordinatorImpl()
        coordinator.navigationController = mockNavigation
        coordinator.overview()
        XCTAssertTrue(mockNavigation.currentController is OverviewController)
    }
    
    func testCoordinatorDetail() {
        let mockNavigation = NavigationControllerMock()
        let coordinator = ViewCoordinatorImpl()
        coordinator.navigationController = mockNavigation
        coordinator.detail(nil)
        XCTAssertTrue(mockNavigation.currentController is DetailController)
    }
    
    func testCoordinatorBack() {
        let mockNavigation = NavigationControllerMock()
        let coordinator = ViewCoordinatorImpl()
        coordinator.navigationController = mockNavigation
        coordinator.overview()
        coordinator.detail(nil)
        coordinator.back()
        XCTAssertTrue(mockNavigation.currentController is OverviewController)
    }
    
}

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
