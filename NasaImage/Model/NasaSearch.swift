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
    let items: NasaItems
    let links: [NasaLink]
}

class NasaItems: Codable {
    let data: [NasaImage]
}
