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
        var calledBack = false
        let networking = NetworkServiceImpl()
        networking.session = session
        networking.reachability = ReachabilityServiceMock(true)
        URLProtocolMock.requestHandler = { _ in
            return (200, Util.validSearch)
        }
        _ = networking.get(urlString: Util.invalidUrl) { data, error in
            calledBack = true
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(calledBack)
    }
    
    func testError() {
        var calledBack = false
        let networking = NetworkServiceImpl()
        networking.session = session
        networking.reachability = ReachabilityServiceMock(true)
        URLProtocolMock.requestHandler = { _ in
            throw Util.testError
        }
        _ = networking.get(urlString: Util.invalidUrl) { data, error in
            calledBack = true
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(calledBack)
    }
    
    func testBadStatus() {
        var calledBack = false
        let networking = NetworkServiceImpl()
        networking.session = session
        networking.reachability = ReachabilityServiceMock(true)
        URLProtocolMock.requestHandler = { _ in
            return (300, nil)
        }
        _ = networking.get(urlString: Util.invalidUrl) { data, error in
            calledBack = true
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(calledBack)
    }
    
    func testBadStatusWithValidData() {
        var calledBack = false
        let networking = NetworkServiceImpl()
        networking.session = session
        networking.reachability = ReachabilityServiceMock(true)
        URLProtocolMock.requestHandler = { _ in
            return (300, Util.validSearch)
        }
        _ = networking.get(urlString: Util.invalidUrl) { data, error in
            calledBack = true
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(calledBack)
    }
    
    func testEmptyBody() {
        var calledBack = false
        let networking = NetworkServiceImpl()
        networking.session = session
        networking.reachability = ReachabilityServiceMock(true)
        URLProtocolMock.requestHandler = { _ in
            return (200, nil)
        }
        _ = networking.get(urlString: Util.invalidUrl) { data, error in
            calledBack = true
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(calledBack)
    }
    
    func testInvalidUrl() {
        var calledBack = false
        let networking = NetworkServiceImpl()
        networking.reachability = ReachabilityServiceMock(true)
        _ = networking.get(urlString: Util.invalidUrl) { data, error in
            calledBack = true
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(calledBack)
    }
    
    func testNetworkNotReachable() {
        var calledBack = false
        let networking = NetworkServiceImpl()
        networking.reachability = ReachabilityServiceMock(false)
        _ = networking.get(urlString: Util.validUrl) { data, error in
            calledBack = true
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
        XCTAssertTrue(calledBack)
    }
}
