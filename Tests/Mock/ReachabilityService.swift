//
//  ReachabilityService.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import Foundation
@testable import NasaImage

class ReachabilityServiceMock: ReachabilityService {
    let isConnectedToNetwork: Bool
    init(_ isReachable: Bool) {
        isConnectedToNetwork = isReachable
    }
}
