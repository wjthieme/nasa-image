//
//  ApiService.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

typealias SearchCallback = ((Result<NasaSearch, Error>) -> Void)
typealias ImageCallback = ((Result<UIImage, Error>) -> Void)

protocol ApiService {
    func search(_ query: String, page: Int, completion: @escaping SearchCallback) -> CancellationToken
    func getImage(_ id: String, size: ImageType, completion: @escaping ImageCallback) -> CancellationToken
}

class ApiServiceImpl: ApiService {
    var networkService: NetworkService = NetworkServiceImpl()
    
    func search(_ query: String, page: Int, completion: @escaping SearchCallback) -> CancellationToken {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let urlString = "https://images-api.nasa.gov/search?q=\(encodedQuery)&media_type=image&page=\(page)"
        return networkService.get(urlString: urlString) { data, error in
            do {
                if let error = error { throw error }
                guard let data = data else { throw CocoaError(.coderReadCorrupt) }
                let response = try JSONDecoder().decode(NasaSearch.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getImage(_ id: String, size: ImageType, completion: @escaping ImageCallback) -> CancellationToken {
        let encodedId = id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let urlString = "https://images-assets.nasa.gov/image/\(encodedId)/\(encodedId)~\(size.rawValue).jpg"
        return networkService.get(urlString: urlString) { data, error in
            do {
                if let error = error { throw error }
                guard let data = data else { throw CocoaError(.coderReadCorrupt) }
                guard let image = UIImage(data: data) else { throw CocoaError(.coderInvalidValue) }
                completion(.success(image))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
