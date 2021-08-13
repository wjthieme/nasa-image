//
//  URLProtocol.swift
//  Tests
//
//  Created by Wilhelm Thieme on 13/08/2021.
//

import Foundation

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
