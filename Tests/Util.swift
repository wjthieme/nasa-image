//
//  Constants.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import UIKit
@testable import NasaImage

class Util {
    
    static let validUrl = "https://google.com"
    static let invalidUrl = "10913i 1930 35"
    
    static let testBundle = Bundle(for: Util.self)
    
    static let testError = NSError(domain: "testError", code: 0, userInfo: nil)
    static let validSearch: Data = {
        let url = testBundle.url(forResource: "search_valid", withExtension: "json")!
        return try! Data(contentsOf: url)
    }()

    static let invalidSearch: Data = {
        let url = testBundle.url(forResource: "search_invalid", withExtension: "json")!
        return try! Data(contentsOf: url)
    }()
    
    static let validImage: Data = {
        let url = testBundle.url(forResource: "test_image", withExtension: "jpg")!
        return try! Data(contentsOf: url)
    }()
    
    static let testImage: UIImage = {
        return UIImage(data: validImage)!
    }()
    
    static let testSearch: NasaSearch = {
        return try! JSONDecoder().decode(NasaSearch.self, from: validSearch)
    }()
    
    static let testAsset: NasaAsset = {
        return testSearch.collection.items.first!.data.first!
    }()
    
    
    static func takeScreenshot(of controller: UIViewController) -> UIImage {
        let window = UIApplication.shared.windows.first!
        window.rootViewController = controller
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(window.layer.frame.size, false, scale);
       let context = UIGraphicsGetCurrentContext()!
        window.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
     }
    
}
