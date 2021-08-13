//
//  OverviewViewModel.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import UIKit
@testable import NasaImage

class OverviewViewModelMock: OverviewViewModel {
    var imagesDidUpdate: ((Int) -> Void)?
    var updateError: ((Error) -> Void)?
    func numberOfItems() -> Int { return 7 }
    func image(_ index: Int) -> UIImage? { return Util.testImage }
    func startUpdating(_ query: String, fresh: Bool) { }
    func didPressItem(_ index: Int) { }
    func itemsPerRow() -> Int { return 3 }
    func shouldShowFooter() -> Bool { return true }
}
