//
//  BaseViewModel.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

class BaseViewModel: NSObject {
    var coordinatior: ViewCoordinator = ViewCoordinatorImpl()
    var apiService: ApiService = ApiServiceImpl()
    var deviceService: DeviceService = DeviceServiceImpl()
}
