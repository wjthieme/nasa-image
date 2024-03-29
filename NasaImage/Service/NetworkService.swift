//
//  NetworkingService.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import Foundation

typealias CancellationToken = (() -> Void)
typealias DataCompletion = ((Data?, Error?) -> Void)

protocol NetworkService {
    func get(urlString: String, completion: @escaping DataCompletion) -> CancellationToken
}

class NetworkServiceImpl: NetworkService {
    var session: URLSession = URLSession.shared
    var reachability: ReachabilityService = ReachabilityServiceImpl()
    
    func get(urlString: String, completion: @escaping DataCompletion) -> CancellationToken {
        guard reachability.isConnectedToNetwork else {
            completion(nil, NetworkingError.notConnectedToNetwork)
            return { }
        }
        guard let url = URL(string: urlString) else {
            completion(nil, NetworkingError.malformedUrl(urlString))
            return { }
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            do {
                if let error = error { throw error }
                guard let response = response as? HTTPURLResponse else { throw NetworkingError.emptyResponse(request) }
                guard (200..<300).contains(response.statusCode) else { throw NetworkingError.httpError(request, response.statusCode) }
                guard let data = data else { throw NetworkingError.emptyBody(request) }
                DispatchQueue.main.async { completion(data, nil) }
            } catch {
                DispatchQueue.main.async { completion(nil, error as NSError) }
            }
        }
        task.resume()
        return { task.cancel() }
    }
    
}

