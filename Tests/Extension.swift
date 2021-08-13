//
//  Extension.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import XCTest

extension XCTestCase {
    func addSnapshot(of controller: UIViewController) {
        let window = UIApplication.shared.windows.first!
        window.rootViewController = controller
        
        let expectation = XCTestExpectation(description: "Loading View")
        var image: UIImage?
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let scale = UIScreen.main.scale
            UIGraphicsBeginImageContextWithOptions(window.layer.frame.size, false, scale)
            let context = UIGraphicsGetCurrentContext()!
            window.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        let attachment = XCTAttachment(image: image!)
        attachment.lifetime = .keepAlways
        add(attachment)
     }
}
