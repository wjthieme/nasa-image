//
//  DetailViewModel.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

protocol DetailViewModel: AnyObject {
    var didLoadImage: (() -> Void)? { get set }
    func backButtonPressed()
    func startLoadImage()
    var image: UIImage? { get }
    var title: String { get }
    var explanation: String { get }
    var information: String { get }
}

class DetailViewModelImpl: BaseViewModel, DetailViewModel {
    var didLoadImage: (() -> Void)?
    var asset: NasaAsset?
    var image: UIImage?
    var title: String { return asset?.title ?? NSLocalizedString("noTitle", comment: "") }
    var explanation: String { return asset?.explanation ?? NSLocalizedString("noDescription", comment: "") }
    var information: String {
        return NSLocalizedString("infoTemplate", comment: "")
            .replacingOccurrences(of: "%0", with: asset?.location ?? NSLocalizedString("unknown", comment: ""))
            .replacingOccurrences(of: "%1", with: asset?.photographer ?? NSLocalizedString("unknown", comment: ""))
    }
    
    init(_ image: NasaAsset? = nil) {
        asset = image
    }
    
    func backButtonPressed() {
        coordinatior.back()
    }
    
    func startLoadImage() {
        guard let asset = asset else { return }
        _ = apiService.getImage(asset.id, size: .large) { [self] result in
            switch result {
            case .success(let newImage): image = newImage
            case .failure(_): image = UIImage(named: "DefaultImage")
            }
            didLoadImage?()
        }
    }
}
