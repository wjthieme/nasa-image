//
//  NetworkingService.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import Foundation
@testable import NasaImage

class NetworkingServiceMock: NetworkingService {
    private(set) var urlString: String?
    private(set) var cancelled = false
    private let response: Data?
    private let error: NSError?
    private let shouldComplete: Bool
    
    init(response: Data? = nil, error: NSError? = nil, shouldComplete: Bool = true) {
        self.response = response
        self.error = error
        self.shouldComplete = shouldComplete
    }
    
    func get(urlString: String, completion: @escaping DataCompletion) -> CancellationToken {
        self.urlString = urlString
        self.cancelled = false
        
        if shouldComplete {
            completion(response, error)
        }
        
        return { self.cancelled = true }
    }
}
