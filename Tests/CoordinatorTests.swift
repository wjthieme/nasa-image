//
//  CoordinatorTests.swift
//  Tests
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import XCTest
@testable import NasaImage

class CoordinatorTests: XCTestCase {
    
    func testCoordinatorInitialState() {
        let mockNavigation = NavigationControllerMock()
        let coordinator = ViewCoordinatorImpl()
        coordinator.navigationController = mockNavigation
        XCTAssertFalse(mockNavigation.controller is OverviewController)
        XCTAssertFalse(mockNavigation.controller is DetailController)
    }
    
    func testCoordinatorOverview() {
        let mockNavigation = NavigationControllerMock()
        let coordinator = ViewCoordinatorImpl()
        coordinator.navigationController = mockNavigation
        coordinator.overview()
        XCTAssertTrue(mockNavigation.controller is OverviewController)
    }
    
    func testCoordinatorDetail() {
        let mockNavigation = NavigationControllerMock()
        let coordinator = ViewCoordinatorImpl()
        coordinator.navigationController = mockNavigation
        coordinator.detail(nil)
        XCTAssertTrue(mockNavigation.controller is DetailController)
    }
    
}

class NavigationControllerMock: NavigationController {
    var controller: UIViewController?
    func navigate(to controller: UIViewController, animated: Bool) {
        self.controller = controller
    }
}
