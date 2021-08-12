//
//  DetailViewModel.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import Foundation

protocol DetailViewModel: BaseViewModel {
    func bind(_ controller: DetailController)
}

class DetailViewModelImpl: BaseViewModel, DetailViewModel {
    
    
    func bind(_ controller: DetailController) {

    }
    
}
