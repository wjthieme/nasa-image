//
//  NasaSearch.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import Foundation

class NasaSearch: Codable, Equatable {
    static func == (lhs: NasaSearch, rhs: NasaSearch) -> Bool { lhs.collection == rhs.collection }
    
    let collection: NasaCollection
}

class NasaCollection: Codable, Equatable {
    static func == (lhs: NasaCollection, rhs: NasaCollection) -> Bool { lhs.items == rhs.items }
    
    let items: [NasaItems]
    let metadata: NasaMetadata
}

class NasaMetadata: Codable, Equatable {
    static func == (lhs: NasaMetadata, rhs: NasaMetadata) -> Bool { return lhs.totalItems == rhs.totalItems }
    
    let totalItems: Int
    
    private enum CodingKeys: String, CodingKey {
        case totalItems = "total_hits"
    }
}

class NasaItems: Codable, Equatable {
    static func == (lhs: NasaItems, rhs: NasaItems) -> Bool { lhs.data == rhs.data }
    
    let data: [NasaAsset]
}
