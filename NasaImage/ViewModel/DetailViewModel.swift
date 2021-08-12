//
//  DetailViewModel.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import Foundation

protocol DetailViewModel: AnyObject {
    
}

class DetailViewModelImpl: BaseViewModel, DetailViewModel {
    
    init(_ image: NasaAsset? = nil) {
        
    }
    
}
