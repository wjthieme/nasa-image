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
        let networking = NetworkingServiceImpl()
        networking.session = session
        networking.reachability = ReachabilityServiceMock(true)
        URLProtocolMock.requestHandler = { _ in
            return (200, Util.validSearch)
        }
        _ = networking.get(urlString: Util.invalidUrl) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testError() {
        let networking = NetworkingServiceImpl()
        networking.session = session
        networking.reachability = ReachabilityServiceMock(true)
        URLProtocolMock.requestHandler = { _ in
            throw Util.testError
        }
        _ = networking.get(urlString: Util.invalidUrl) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testBadStatus() {
        let networking = NetworkingServiceImpl()
        networking.session = session
        networking.reachability = ReachabilityServiceMock(true)
        URLProtocolMock.requestHandler = { _ in
            return (300, nil)
        }
        _ = networking.get(urlString: Util.invalidUrl) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testBadStatusWithValidData() {
        let networking = NetworkingServiceImpl()
        networking.session = session
        networking.reachability = ReachabilityServiceMock(true)
        URLProtocolMock.requestHandler = { _ in
            return (300, Util.validSearch)
        }
        _ = networking.get(urlString: Util.invalidUrl) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testEmptyBody() {
        let networking = NetworkingServiceImpl()
        networking.session = session
        networking.reachability = ReachabilityServiceMock(true)
        URLProtocolMock.requestHandler = { _ in
            return (200, nil)
        }
        _ = networking.get(urlString: Util.invalidUrl) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testInvalidUrl() {
        let networking = NetworkingServiceImpl()
        networking.reachability = ReachabilityServiceMock(true)
        _ = networking.get(urlString: Util.invalidUrl) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
    
    func testNetworkNotReachable() {
        let networking = NetworkingServiceImpl()
        networking.reachability = ReachabilityServiceMock(false)
        _ = networking.get(urlString: Util.validUrl) { data, error in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
}

class ReachabilityServiceMock: ReachabilityService {
    let isConnectedToNetwork: Bool
    init(_ isReachable: Bool) {
        isConnectedToNetwork = isReachable
    }
}

class URLProtocolMock: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (Int, Data?))!
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
        
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
        
    override func startLoading() {
        do {
            let (status, data) = try URLProtocolMock.requestHandler(request)
            let response = HTTPURLResponse(url: request.url!, statusCode: status, httpVersion: nil, headerFields: nil)!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
        
    override func stopLoading() {
        
    }
}
