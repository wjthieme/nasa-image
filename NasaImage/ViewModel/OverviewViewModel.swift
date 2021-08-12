//
//  OverviewViewModel.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

protocol OverviewViewModel: BaseViewModel {
    func bind(_ controller: OverviewController)
}

class OverviewViewModelImpl: BaseViewModel, OverviewViewModel {
    weak var collectionView: UICollectionView?
    weak var refreshControl: UIRefreshControl?
    
    var images: [NasaImage] = []

    func bind(_ controller: OverviewController) {
        collectionView = controller.collectionView
        refreshControl = controller.refreshControl
        controller.collectionView.delegate = self
        controller.collectionView.dataSource = self
        controller.searchBar.delegate = self
        controller.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        
        refreshControl?.endRefreshing()
    }
    
}

extension OverviewViewModelImpl: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
        
        return cell
    }
}

extension OverviewViewModelImpl: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

