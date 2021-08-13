//
//  ApiService.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import UIKit
@testable import NasaImage

class ApiServiceMock: ApiService {
    var searchHandler: ((String, Int) -> Result<NasaSearch, Error>)?
    var imageHandler: ((String, ImageType) -> Result<UIImage, Error>)?
    
    
    func search(_ query: String, page: Int, completion: @escaping SearchCallback) -> CancellationToken {
        if let result = searchHandler?(query, page) {
            completion(result)
        }
        return { }
    }
    
    func getImage(_ id: String, size: ImageType, completion: @escaping ImageCallback) -> CancellationToken {
        if let result = imageHandler?(id, size) {
            completion(result)
        }
        return { }
    }
}
