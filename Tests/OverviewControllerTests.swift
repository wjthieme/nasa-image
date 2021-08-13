//
//  OverviewControllerSnapshot.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import XCTest
@testable import NasaImage

class OverviewControllerTests: XCTestCase {
    
    func testSnapshot() {
        let controller = OverviewController()
        controller.viewModel = OverviewViewModelMock()
        addSnapshot(of: controller)
    }
    
    func testSnapshotFailure() {
        let viewModel = OverviewViewModelMock()
        viewModel.updateSuccessful = false
        let controller = OverviewController()
        controller.viewModel = viewModel
        addSnapshot(of: controller)
    }
    
    func testSnapshotWithLoader() {
        let viewModel = OverviewViewModelMock()
        viewModel.showFooter = true
        viewModel.callbacks = false
        let controller = OverviewController()
        controller.viewModel = viewModel
        addSnapshot(of: controller)
    }
}


