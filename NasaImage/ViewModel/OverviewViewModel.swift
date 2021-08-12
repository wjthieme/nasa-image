//
//  OverviewViewModel.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

protocol OverviewViewModel: AnyObject {
    var imagesDidUpdate: ((Int) -> Void)? { get set }
    var updateError: ((Error) -> Void)? { get set }
    func numberOfItems() -> Int
    func image(_ index: Int) -> UIImage?
    func title(_ index: Int) -> String?
    func startUpdating(_ query: String, page: Int)
    func didPressItem(_ index: Int)
    func itemsPerRow() -> Int
}

class OverviewViewModelImpl: BaseViewModel, OverviewViewModel {
    private var cancelUpdate: CancellationToken?
    var images: [NasaAsset] = []
    var thumbs: [String: UIImage] = [:]
    
    var imagesDidUpdate: ((Int) -> Void)?
    var updateError: ((Error) -> Void)?
    
    func numberOfItems() -> Int {
        return images.count
    }

    func image(_ index: Int) -> UIImage? {
        return thumbs[images[index].id]
    }
    
    func title(_ index: Int) -> String? {
        return images[index].title
    }
    
    func startUpdating(_ query: String, page: Int) {
        cancelUpdate?()
        cancelUpdate = apiService.search(query, page: page) { [self] result in
            switch result {
            case .success(let response):
                images = response.collection.items.compactMap { $0.data.first }
                imagesDidUpdate?(-1)
                startDownloadingThumbs()
            case .failure(let error):
                updateError?(error)
            }
        }
    }
    
    func startDownloadingThumbs() {
        for (offset, asset) in images.enumerated() {
            _ = apiService.getImage(asset.id, size: .thumb, completion: { [self] result in
                switch result {
                case .success(let image): thumbs[asset.id] = image
                case .failure(_): thumbs[asset.id] = UIImage(named: "DefaultImage")
                }
                imagesDidUpdate?(offset)
            })
        }
    }
    
    func didPressItem(_ index: Int) {
        coordinatior.detail(images[index])
    }
    
    func itemsPerRow() -> Int {
        let isLandscape = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: return isLandscape ? 5 : 3
        case .pad, .mac: return 5
        default: return 3
        }
    }

}

