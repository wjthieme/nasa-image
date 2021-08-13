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


