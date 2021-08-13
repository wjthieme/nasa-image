//
//  OverviewViewModelTests.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import XCTest
@testable import NasaImage

class OverviewViewModelTests: XCTestCase {
    
    func testFields() {
        var calledBack = 0
        let mockApi = ApiServiceMock()
        mockApi.searchHandler = { _, _ in return .success(Util.testSearch)}
        mockApi.imageHandler = { _, _ in return .success(Util.testImage) }
        let viewModel = OverviewViewModelImpl()
        viewModel.apiService = mockApi
        viewModel.imagesDidUpdate = { _ in
            calledBack += 1
        }
        viewModel.updateError = { _ in
            calledBack -= 1
        }
        viewModel.startUpdating("", fresh: true)
        XCTAssertEqual(calledBack, 2)
        XCTAssertEqual(viewModel.numberOfItems(), 1)
        XCTAssertEqual(viewModel.image(0), Util.testImage)
        XCTAssertTrue(viewModel.shouldShowFooter())
        
        viewModel.startUpdating("", fresh: false)
        XCTAssertEqual(calledBack, 3)
        XCTAssertEqual(viewModel.numberOfItems(), 2)
        XCTAssertEqual(viewModel.image(1), Util.testImage)
        XCTAssertFalse(viewModel.shouldShowFooter())
        
        viewModel.startUpdating("", fresh: true)
        XCTAssertEqual(calledBack, 4)
        XCTAssertEqual(viewModel.numberOfItems(), 1)
        XCTAssertEqual(viewModel.image(0), Util.testImage)
        XCTAssertTrue(viewModel.shouldShowFooter())
    }
    
    func testFieldsFailed() {
        var calledBack = 0
        let mockApi = ApiServiceMock()
        mockApi.searchHandler = { _, _ in return .failure(Util.testError)}
        mockApi.imageHandler = { _, _ in return .success(Util.testImage) }
        let viewModel = OverviewViewModelImpl()
        viewModel.apiService = mockApi
        viewModel.imagesDidUpdate = { _ in
            calledBack += 1
        }
        viewModel.updateError = { _ in
            calledBack -= 1
        }
        
        viewModel.startUpdating("", fresh: true)
        XCTAssertEqual(calledBack, -1)
        XCTAssertEqual(viewModel.numberOfItems(), 0)
        XCTAssertEqual(viewModel.image(0), nil)
        XCTAssertFalse(viewModel.shouldShowFooter())
    }
    
    func testFieldsFailedImage() {
        var calledBack = 0
        let mockApi = ApiServiceMock()
        mockApi.searchHandler = { _, _ in return .success(Util.testSearch)}
        mockApi.imageHandler = { _, _ in return .failure(Util.testError) }
        let viewModel = OverviewViewModelImpl()
        viewModel.apiService = mockApi
        viewModel.imagesDidUpdate = { _ in
            calledBack += 1
        }
        viewModel.updateError = { _ in
            calledBack -= 1
        }
        viewModel.startUpdating("", fresh: true)
        XCTAssertEqual(calledBack, 2)
        XCTAssertEqual(viewModel.numberOfItems(), 1)
        XCTAssertEqual(viewModel.image(0), UIImage(named: "DefaultImage"))
        XCTAssertTrue(viewModel.shouldShowFooter())
    }
    
    func testImagesPerRow() {
        let mockDeviceService = DeviceServiceMock()
        let viewModel = OverviewViewModelImpl()
        viewModel.deviceService = mockDeviceService
        XCTAssertEqual(viewModel.itemsPerRow(), 3)
        mockDeviceService.isLandscape = true
        XCTAssertEqual(viewModel.itemsPerRow(), 5)
        mockDeviceService.isBigScreen = true
        XCTAssertEqual(viewModel.itemsPerRow(), 5)
        mockDeviceService.isLandscape = false
        XCTAssertEqual(viewModel.itemsPerRow(), 5)
    }
    
    func testNavigation() {
        var calledBack = false
        let mockCoordinator = ViewCoordinatorMock()
        mockCoordinator.detailCallback = { _ in
            calledBack = true
        }
        let mockApi = ApiServiceMock()
        mockApi.searchHandler = { _, _ in return .success(Util.testSearch)}
        let viewModel = OverviewViewModelImpl()
        viewModel.coordinatior = mockCoordinator
        viewModel.apiService = mockApi
        viewModel.startUpdating("", fresh: true)
        viewModel.didPressItem(0)
        XCTAssertTrue(calledBack)
    }
    
}
