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
        _ = ViewCoordinatorImpl(mockNavigation)
        XCTAssert(mockNavigation.controller is OverviewController)
    }
    
    func testCoordinatorOverview() {
        let mockNavigation = MockNavigation()
        let coordinator = ViewCoordinatorImpl(mockNavigation)
        coordinator.overview()
        XCTAssert(mockNavigation.controller is OverviewController)
    }
    
    func testCoordinatorDetail() {
        let mockNavigation = MockNavigation()
        let coordinator = ViewCoordinatorImpl(mockNavigation)
        coordinator.detail()
        XCTAssert(mockNavigation.controller is DetailController)
    }
    
}

class MockNavigation: UIViewController, NavigationController {
    var controller: UIViewController?
    func navigate(to controller: UIViewController, animated: Bool) {
        self.controller = controller
    }
}
