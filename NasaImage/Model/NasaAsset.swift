//
//  NasaImage.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import Foundation

class NasaAsset: Codable {
    let id: String
    let title: String?
    let description: String?
    let photographer: String?
    let location: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "nasa_id", title, description, photographer, location
    }
}
