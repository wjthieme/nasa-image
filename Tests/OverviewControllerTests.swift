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
        let snapshot = Util.takeScreenshot(of: controller)
        let attachment = XCTAttachment(image: snapshot)
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

class OverviewViewModelMock: OverviewViewModel {
    var imagesDidUpdate: ((Int) -> Void)?
    var updateError: ((Error) -> Void)?
    func numberOfItems() -> Int { return 7 }
    func image(_ index: Int) -> UIImage? { return UIImage(data: Util.testImage) }
    func startUpdating(_ query: String, page: Int) { }
    func didPressItem(_ index: Int) { }
    func itemsPerRow() -> Int { return 3 }
}
