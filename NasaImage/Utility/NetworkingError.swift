//
//  NetworkingError.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import Foundation

enum NetworkingError: Error {
    case notConnectedToNetwork
    case malformedUrl(_ url: String)
    case emptyResponse(_ request: URLRequest)
    case emptyBody(_ request: URLRequest)
    case httpError(_ request: URLRequest, _ code: Int)
}
