//
//  DetailController.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

class DetailController: UIViewController {
    
    var viewModel: DetailViewModel = DetailViewModelImpl()
    
    var imageViewAspect: NSLayoutConstraint?
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    let statusBarView = UIView()
    let backButton = UIButton()
    let titleLabel = UILabel()
    let explanationLabel = UILabel()
    let informationLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureScrollView()
        configureStatusBarView()
        configureBackButton()
        configureTitleLabel()
        configureImageView()
        configureExplanationLabel()
        configureInformationLabel()
        
        viewModel.didLoadImage = { [weak self] in self?.finishedLoadingImage() }
        
        viewModel.startLoadImage()
    }
    
    func configureScrollView() {
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        scrollView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        
        view.addSubview(scrollView)
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureStatusBarView() {
        statusBarView.backgroundColor = UIColor(named: "AccentColor")
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(statusBarView)
        
        statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        statusBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        statusBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44).isActive = true
        
    }
    
    func configureBackButton() {
        let image = UIImage(systemName: "chevron.left")
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(image, for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func configureTitleLabel() {
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.text = viewModel.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        view.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    
    func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        scrollView.addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageViewAspect = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        imageViewAspect?.isActive = true
    }
    
    func configureExplanationLabel() {
        explanationLabel.textAlignment = .justified
        explanationLabel.translatesAutoresizingMaskIntoConstraints = false
        explanationLabel.text = viewModel.explanation
        explanationLabel.numberOfLines = 0
        scrollView.addSubview(explanationLabel)
        explanationLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 24).isActive = true
        explanationLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -24).isActive = true
        explanationLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24).isActive = true
    }
    
    func configureInformationLabel() {
        informationLabel.textAlignment = .left
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.text = viewModel.information
        informationLabel.font = UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)
        informationLabel.numberOfLines = 0
        scrollView.addSubview(informationLabel)
        informationLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 24).isActive = true
        informationLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -24).isActive = true
        informationLabel.topAnchor.constraint(equalTo: explanationLabel.bottomAnchor).isActive = true
        informationLabel.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -24).isActive = true
    }
    
}

extension DetailController {
    func finishedLoadingImage() {
        imageView.image = viewModel.image
        let aspect = (viewModel.image?.size.height ?? 1) / (viewModel.image?.size.width ?? 1)
        imageViewAspect?.isActive = false
        imageViewAspect = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspect)
        imageViewAspect?.isActive = true
        
        scrollView.bounces = scrollView.contentSize.height > view.frame.height
    }
}

extension DetailController {
    @objc func backButtonPressed(sender: UIButton) {
        viewModel.backButtonPressed()
    }
}
