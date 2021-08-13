//
//  Result.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import Foundation

extension Result {
    var isSuccess: Bool {
        switch self {
        case .success(_): return true
        case .failure(_): return false
        }
    }
}
