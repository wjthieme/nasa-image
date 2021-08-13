//
//  DetailControllerSnapshot.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import XCTest
@testable import NasaImage

class DetailControllerTests: XCTestCase {
    
    
    func testSnapshot() {
        let controller = DetailController()
        controller.viewModel = DetailViewModelMock()
        let snapshot = Util.takeScreenshot(of: controller)
        let attachment = XCTAttachment(image: snapshot)
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

class DetailViewModelMock: DetailViewModel {
    
}
