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
        let mockNetwork = NetworkingServiceMock()
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.search("Apollo/ \\!@#$%^&", page: 1, completion: { _ in })
        XCTAssertEqual(mockNetwork.urlString, "https://images-api.nasa.gov/search?q=Apollo%2F%20%5C!%40%23$%25%5E&&media_type=image&page=1")
    }
    
    func testSearchParse() {
        let mockNetwork = NetworkingServiceMock(response: Util.validSearch)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.search("", page: 1) { result in
            XCTAssertTrue(result.isSuccess)
        }
    }
    
    func testSearchParseFail() {
        let mockNetwork = NetworkingServiceMock(response: Util.invalidSearch)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.search("", page: 1) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testSearchError() {
        let mockNetwork = NetworkingServiceMock(error: Util.testError)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.search("", page: 1) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testSearchErrorWithValidData() {
        let mockNetwork = NetworkingServiceMock(response: Util.validSearch, error: Util.testError)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.search("", page: 1) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testSearchEmpty() {
        let mockNetwork = NetworkingServiceMock()
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.search("", page: 1) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testSearchCancel() {
        let mockNetwork = NetworkingServiceMock(shouldComplete: false)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        let cancelRequest = apiService.search("", page: 1, completion: { _ in })
        cancelRequest()
        XCTAssertTrue(mockNetwork.cancelled)
    }
    
    func testGetImageUrl() {
        let mockNetwork = NetworkingServiceMock()
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.getImage("Apollo/ \\!@#$%^&", size: .medium, completion: { _ in })
        XCTAssertEqual(mockNetwork.urlString, "https://images-assets.nasa.gov/image/Apollo%2F%20%5C!%40%23$%25%5E&/Apollo%2F%20%5C!%40%23$%25%5E&~medium.jpg")
    }
    
    func testGetImageParse() {
        let mockNetwork = NetworkingServiceMock(response: Util.testImage)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.getImage("", size: .medium) { result in
            XCTAssertTrue(result.isSuccess)
        }
    }
    
    func testGetImageParseFail() {
        let mockNetwork = NetworkingServiceMock(response: Util.invalidSearch)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.getImage("", size: .medium) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testGetImageError() {
        let mockNetwork = NetworkingServiceMock(error: Util.testError)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.getImage("", size: .medium) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testGetImageErrorWithValidData() {
        let mockNetwork = NetworkingServiceMock(response: Util.validSearch, error: Util.testError)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.getImage("", size: .medium) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testGetImageEmpty() {
        let mockNetwork = NetworkingServiceMock()
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.getImage("", size: .medium) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testGetImageCancel() {
        let mockNetwork = NetworkingServiceMock(shouldComplete: false)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        let cancelRequest = apiService.getImage("", size: .medium, completion: { _ in })
        cancelRequest()
        XCTAssertTrue(mockNetwork.cancelled)
    }
    
}

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
