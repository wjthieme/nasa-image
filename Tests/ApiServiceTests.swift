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
        let mockNetwork = NetworkServiceMock()
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.search("Apollo/ \\!@#$%^&", page: 1, completion: { _ in })
        XCTAssertEqual(mockNetwork.urlString, "https://images-api.nasa.gov/search?q=Apollo%2F%20%5C!%40%23$%25%5E&&media_type=image&page=1")
    }
    
    func testSearchParse() {
        let mockNetwork = NetworkServiceMock(response: Util.validSearch)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.search("", page: 1) { result in
            XCTAssertTrue(result.isSuccess)
        }
    }
    
    func testSearchParseFail() {
        let mockNetwork = NetworkServiceMock(response: Util.invalidSearch)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.search("", page: 1) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testSearchError() {
        let mockNetwork = NetworkServiceMock(error: Util.testError)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.search("", page: 1) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testSearchErrorWithValidData() {
        let mockNetwork = NetworkServiceMock(response: Util.validSearch, error: Util.testError)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.search("", page: 1) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testSearchEmpty() {
        let mockNetwork = NetworkServiceMock()
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.search("", page: 1) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testSearchCancel() {
        let mockNetwork = NetworkServiceMock(shouldComplete: false)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        let cancelRequest = apiService.search("", page: 1, completion: { _ in })
        cancelRequest()
        XCTAssertTrue(mockNetwork.cancelled)
    }
    
    func testGetImageUrl() {
        let mockNetwork = NetworkServiceMock()
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.getImage("Apollo/ \\!@#$%^&", size: .medium, completion: { _ in })
        XCTAssertEqual(mockNetwork.urlString, "https://images-assets.nasa.gov/image/Apollo%2F%20%5C!%40%23$%25%5E&/Apollo%2F%20%5C!%40%23$%25%5E&~medium.jpg")
    }
    
    func testGetImageParse() {
        let mockNetwork = NetworkServiceMock(response: Util.validImage)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.getImage("", size: .medium) { result in
            XCTAssertTrue(result.isSuccess)
        }
    }
    
    func testGetImageParseFail() {
        let mockNetwork = NetworkServiceMock(response: Util.invalidSearch)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.getImage("", size: .medium) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testGetImageError() {
        let mockNetwork = NetworkServiceMock(error: Util.testError)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.getImage("", size: .medium) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testGetImageErrorWithValidData() {
        let mockNetwork = NetworkServiceMock(response: Util.validSearch, error: Util.testError)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.getImage("", size: .medium) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testGetImageEmpty() {
        let mockNetwork = NetworkServiceMock()
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        _ = apiService.getImage("", size: .medium) { result in
            XCTAssertFalse(result.isSuccess)
        }
    }
    
    func testGetImageCancel() {
        let mockNetwork = NetworkServiceMock(shouldComplete: false)
        let apiService = ApiServiceImpl()
        apiService.networkService = mockNetwork
        let cancelRequest = apiService.getImage("", size: .medium, completion: { _ in })
        cancelRequest()
        XCTAssertTrue(mockNetwork.cancelled)
    }
    
}
