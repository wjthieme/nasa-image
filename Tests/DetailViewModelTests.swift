//
//  DetailViewModelTests.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import XCTest
@testable import NasaImage

class DetailViewModelTests: XCTestCase {
    
    
    func testFields() {
        let viewModel = DetailViewModelImpl(Util.testAsset)
        XCTAssertEqual(viewModel.title, "Apollo 11 50th Anniversary Celebration")
        XCTAssertEqual(viewModel.explanation, "The Moon is seen.")
        XCTAssertEqual(viewModel.information, "Location: National Mall, Photographer: NASA/Connie Moore")
    }
    
    func testFieldsEmpty() {
        let viewModel = DetailViewModelImpl()
        XCTAssertEqual(viewModel.title, "No Title")
        XCTAssertEqual(viewModel.explanation, "No Description")
        XCTAssertEqual(viewModel.information, "Location: Unknown, Photographer: Unknown")
    }
    
    func testImageSuccess() {
        var calledBack = false
        let mockService = ApiServiceMock()
        mockService.imageHandler = { _, _ in return .success(Util.testImage) }
        let viewModel = DetailViewModelImpl(Util.testAsset)
        viewModel.didLoadImage = { calledBack = true }
        viewModel.apiService = mockService
        XCTAssertNil(viewModel.image)
        viewModel.startLoadImage()
        XCTAssertEqual(viewModel.image, Util.testImage)
        XCTAssertTrue(calledBack)
    }
    
    func testImageFailed() {
        var calledBack = false
        let mockService = ApiServiceMock()
        mockService.imageHandler = { _, _ in return .failure(Util.testError) }
        let viewModel = DetailViewModelImpl(Util.testAsset)
        viewModel.didLoadImage = { calledBack = true }
        viewModel.apiService = mockService
        XCTAssertNil(viewModel.image)
        viewModel.startLoadImage()
        XCTAssertEqual(viewModel.image, UIImage(named: "DefaultImage"))
        XCTAssertTrue(calledBack)
    }
    
    func testImageNoAsset() {
        var calledBack = false
        let mockService = ApiServiceMock()
        mockService.imageHandler = { _, _ in return .success(Util.testImage) }
        let viewModel = DetailViewModelImpl()
        viewModel.didLoadImage = { calledBack = true }
        viewModel.apiService = mockService
        XCTAssertNil(viewModel.image)
        viewModel.startLoadImage()
        XCTAssertEqual(viewModel.image, nil)
        XCTAssertFalse(calledBack)
    }
    
    func testBackButtonAction() {
        var calledBack = false
        let mockCoordinator = ViewCoordinatorMock()
        mockCoordinator.backCallback = { calledBack = true }
        let viewModel = DetailViewModelImpl()
        viewModel.coordinatior = mockCoordinator
        viewModel.backButtonPressed()
        XCTAssertTrue(calledBack)
    }
}

