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
    func startUpdating(_ query: String, fresh: Bool)
    func didPressItem(_ index: Int)
    func itemsPerRow() -> Int
    func shouldShowFooter() -> Bool
}

class OverviewViewModelImpl: BaseViewModel, OverviewViewModel {
    private var cancelUpdate: CancellationToken?
    private var images: [NasaAsset] = []
    private var thumbs: [String: UIImage] = [:]
    
    private var currentPage = 0
    private var totalImages = 0
    
    var imagesDidUpdate: ((Int) -> Void)?
    var updateError: ((Error) -> Void)?
    
    func numberOfItems() -> Int {
        return images.count
    }
    
    func shouldShowFooter() -> Bool {
        return images.count > 0 && images.count != totalImages
    }

    func image(_ index: Int) -> UIImage? {
        if index < 0 || index >= images.count { return nil }
        return thumbs[images[index].id]
    }
    
    func startUpdating(_ query: String, fresh: Bool) {
        if fresh { currentPage = 0 }
        cancelUpdate?()
        cancelUpdate = apiService.search(query, page: currentPage+1) { [self] result in
            switch result {
            case .success(let response):
                totalImages = response.collection.metadata.totalItems
                let newImages = response.collection.items.compactMap { $0.data.first }
                if fresh {
                    images = newImages
                } else {
                    images.append(contentsOf: newImages)
                }
                currentPage += 1
                imagesDidUpdate?(-1)
                startDownloadingThumbs()
            case .failure(let error):
                updateError?(error)
            }
        }
    }
    
    private func startDownloadingThumbs() {
        for (offset, asset) in images.enumerated() {
            if let image = thumbs[asset.id], image != UIImage(named: "DefaultImage") {
                continue
            }
            _ = apiService.getImage(asset.id, size: .thumb, completion: { [self] result in
                switch result {
                case .success(let image): thumbs[asset.id] = image
                case .failure(_): thumbs[asset.id] = UIImage(named: "DefaultImage")
                }
                if images.count >= offset {
                    imagesDidUpdate?(offset)
                }
            })
        }
    }
    
    func didPressItem(_ index: Int) {
        coordinatior.detail(images[index])
    }
    
    func itemsPerRow() -> Int {
        if deviceService.isBigScreen || deviceService.isLandscape {
            return 5
        } else {
            return 3
        }
    }

}

