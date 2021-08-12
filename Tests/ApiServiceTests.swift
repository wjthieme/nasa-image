//
//  ApiServiceTests.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import XCTest
@testable import NasaImage

class ApiServiceTests: XCTestCase {
    
    func testSearchUrl() {
        let mockNetwork = MockNetworking()
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.search("Apollo", page: 1, completion: { _ in })
        XCTAssertEqual(mockNetwork.urlString, "https://images-api.nasa.gov/search?q=Apollo&media_type=image&page=1")
    }
    
    func testGetImageUrl() {
        
    }
    
}

class MockNetworking: NetworkingService {
    var urlString: String?
    func get(urlString: String, completion: @escaping DataCompletion) -> CancellationToken {
        self.urlString = urlString
        return { }
    }
}
