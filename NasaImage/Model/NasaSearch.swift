//
//  NasaSearch.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import Foundation

class NasaSearch: Codable {
    let collection: NasaCollection
}

class NasaCollection: Codable {
    let items: [NasaItems]
}

class NasaItems: Codable {
    let data: [NasaAsset]
}
