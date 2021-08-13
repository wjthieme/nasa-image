//
//  ViewCoordinator.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import UIKit
@testable import NasaImage

class ViewCoordinatorMock: ViewCoordinator {
    var overviewCallback: (() -> Void)?
    var detailCallback: ((NasaAsset?) -> Void)?
    var backCallback: (() -> Void)?
    
    func overview() { overviewCallback?() }
    func detail(_ image: NasaAsset?) { detailCallback?(image) }
    func back() { backCallback?()}
}

