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
    var didLoadImage: (() -> Void)?
    func backButtonPressed() { }
    func startLoadImage() { }
    var image: UIImage? { return UIImage(data: Util.testImage) }
    var title: String { return "TestTitle" }
    var explanation: String { return "TestExplanation" }
    var information: String { return "TestInformation" }
}
