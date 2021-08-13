//
//  DetailViewModel.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import UIKit
@testable import NasaImage

class DetailViewModelMock: DetailViewModel {
    var didLoadImage: (() -> Void)?
    func backButtonPressed() { }
    func startLoadImage() { didLoadImage?() }
    var image: UIImage? { return Util.testImage }
    var title: String { return "TestTitle" }
    var explanation: String { return "TestExplanation" }
    var information: String { return "TestInformation" }
}
