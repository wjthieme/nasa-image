//
//  DeviceService.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import UIKit

protocol DeviceService {
    var isLandscape: Bool { get }
    var isBigScreen: Bool { get }
}

class DeviceServiceImpl: DeviceService {
    var isLandscape: Bool { return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false }
    var isBigScreen: Bool { UIDevice.current.userInterfaceIdiom != .phone }
}
