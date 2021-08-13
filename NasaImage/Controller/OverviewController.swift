//
//  ViewController.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

fileprivate let cellReuseIdentifier = "OverviewControllerReuse"
fileprivate let endReuseIdentifier = "OverviewControllerReuseEnd"

class OverviewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var viewModel: OverviewViewModel = OverviewViewModelImpl()

    let statusBarView = UIView()
    let searchBar = UISearchBar()
    let collectionViewLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemBackground
        
        configureStatusBarView()
        configureSearchBar()
        configureCollectionView()
        configureCollectionViewLayout()
        configureRefreshControl()
        
        viewModel.imagesDidUpdate = { [weak self] index in self?.contentShouldUpdate(index) }
        viewModel.updateError = { [weak self] error in self?.shouldShowError(error) }
        
        refresh(refreshControl: refreshControl)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [self] context in
            configureCollectionViewLayout()
        })

    }
    
    func configureStatusBarView() {
        statusBarView.backgroundColor = .black
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(statusBarView)
        
        statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        statusBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        statusBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func configureSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.placeholder = NSLocalizedString("searchPlaceholder", comment: "")
        
        view.addSubview(searchBar)
        
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func configureCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.register(LoaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: endReuseIdentifier)
        
        view.addSubview(collectionView)
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureCollectionViewLayout() {
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        let dim = view.bounds.width / CGFloat(viewModel.itemsPerRow())
        collectionViewLayout.itemSize = CGSize(width: dim, height: dim)
    }
    
    
    func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    func contentShouldUpdate(_ index: Int) {
        if index == -1 {
            refreshControl.endRefreshing()
            collectionView.reloadData()
        } else {
            collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
        }
    }
    
    func shouldShowError(_ error: Error) {
        refreshControl.endRefreshing()
        let title = NSLocalizedString("downloadError", comment: "")
        let message = NSLocalizedString("downloadErrorMessage", comment: "")
        let ok = NSLocalizedString("ok", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ok, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

extension OverviewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        if let cell = cell as? ImageCell {
            cell.imageView.image = viewModel.image(indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didPressItem(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: endReuseIdentifier, for: indexPath)
        cell.isHidden = !viewModel.shouldShowFooter()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if viewModel.shouldShowFooter() {
            let query = (searchBar.text?.isEmpty ?? true) ? searchBar.placeholder : searchBar.text
            viewModel.startUpdating(query ?? "", fresh: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: viewModel.shouldShowFooter() ? 100 : 0)
    }
    
}

extension OverviewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = (searchBar.text?.isEmpty ?? true) ? searchBar.placeholder : searchBar.text
        viewModel.startUpdating(query ?? "", fresh: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        let query = (searchBar.text?.isEmpty ?? true) ? searchBar.placeholder : searchBar.text
        viewModel.startUpdating(query ?? "", fresh: true)
    }
}

extension OverviewController {
    @objc func refresh(refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        let query = (searchBar.text?.isEmpty ?? true) ? searchBar.placeholder : searchBar.text
        viewModel.startUpdating(query ?? "", fresh: true)
    }
}

