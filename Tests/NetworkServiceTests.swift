//
//  NetworkServiceTests.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import XCTest
@testable import NasaImage

class NetworkServiceTests: XCTestCase {
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: configuration)
    }()
    
    func testSuccess() {
        let expectation = XCTestExpectation(description: "Web call")
        let networking = NetworkServiceImpl()
        networking.session = session
        networking.reachability = ReachabilityServiceMock(true)
        URLProtocolMock.requestHandler = { _ in
            return (200, Util.validSearch)
        }
        _ = networking.get(urlString: Util.validUrl) { data, error in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testError() {
        let expectation = XCTestExpectation(description: "Web call")
        let networking = NetworkServiceImpl()
        networking.session = session
        networking.reachability = ReachabilityServiceMock(true)
        URLProtocolMock.requestHandler = { _ in
            throw Util.testError
        }
        _ = networking.get(urlString: Util.validUrl) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testBadStatus() {
        let expectation = XCTestExpectation(description: "Web call")
        let networking = NetworkServiceImpl()
        networking.session = session
        networking.reachability = ReachabilityServiceMock(true)
        URLProtocolMock.requestHandler = { _ in
            return (300, nil)
        }
        _ = networking.get(urlString: Util.validUrl) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testBadStatusWithValidData() {
        let expectation = XCTestExpectation(description: "Web call")
        let networking = NetworkServiceImpl()
        networking.session = session
        networking.reachability = ReachabilityServiceMock(true)
        URLProtocolMock.requestHandler = { _ in
            return (300, Util.validSearch)
        }
        _ = networking.get(urlString: Util.validUrl) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testInvalidUrl() {
        let expectation = XCTestExpectation(description: "Web call")
        let networking = NetworkServiceImpl()
        networking.reachability = ReachabilityServiceMock(true)
        _ = networking.get(urlString: Util.invalidUrl) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testNetworkNotReachable() {
        let expectation = XCTestExpectation(description: "Web call")
        let networking = NetworkServiceImpl()
        networking.reachability = ReachabilityServiceMock(false)
        _ = networking.get(urlString: Util.validUrl) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
