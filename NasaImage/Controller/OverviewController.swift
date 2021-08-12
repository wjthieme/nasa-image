//
//  ViewController.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

protocol OverviewController: UIViewController {
    var viewModel: OverviewViewModel { get }
    var searchBar: UISearchBar { get }
    var collectionView: UICollectionView { get }
    var collectionViewLayout: UICollectionViewFlowLayout { get }
    var refreshControl: UIRefreshControl { get }
}

class OverviewControllerImpl: UIViewController, OverviewController {
    let viewModel: OverviewViewModel

    let statusBarView = UIView()
    let searchBar = UISearchBar()
    let collectionViewLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    let refreshControl = UIRefreshControl()
    
    init(_ viewModel: OverviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemBackground
        
        configureStatusBarView()
        configureSearchBar()
        configureCollectionView()
        configureRefreshControl()
        
        viewModel.bind(self)
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
        
        view.addSubview(searchBar)
        
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func configureCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureRefreshControl() {
        collectionView.addSubview(refreshControl)
    }



}

