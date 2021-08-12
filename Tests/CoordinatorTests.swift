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
        let mockNavigation = MockNavigation()
        let coordinator = ViewCoordinatorImpl()
        coordinator.navigationController = mockNavigation
        XCTAssertFalse(mockNavigation.controller is OverviewController)
        XCTAssertFalse(mockNavigation.controller is DetailController)
    }
    
    func testCoordinatorOverview() {
        let mockNavigation = MockNavigation()
        let coordinator = ViewCoordinatorImpl()
        coordinator.navigationController = mockNavigation
        coordinator.overview()
        XCTAssert(mockNavigation.controller is OverviewController)
    }
    
    func testCoordinatorDetail() {
        let mockNavigation = MockNavigation()
        let coordinator = ViewCoordinatorImpl()
        coordinator.navigationController = mockNavigation
        coordinator.detail(nil)
        XCTAssert(mockNavigation.controller is DetailController)
    }
    
}

class MockNavigation: NavigationController {
    var controller: UIViewController?
    func navigate(to controller: UIViewController, animated: Bool) {
        self.controller = controller
    }
}
