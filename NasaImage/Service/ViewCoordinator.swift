//
//  ViewCoordinator.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

protocol ViewCoordinator: AnyObject {
    var navigationController: NavigationController { get set }
    func overview()
    func detail(_ image: NasaAsset?)
    func back()
}

class ViewCoordinatorImpl: ViewCoordinator {
    var navigationController: NavigationController = NavigationControllerImpl()
    
    func overview() {
        let viewModel = OverviewViewModelImpl()
        viewModel.coordinatior = self
        let controller = OverviewController()
        controller.viewModel = viewModel
        navigationController.navigate(to: controller, animated: true)
    }
    
    func back() {
        navigationController.pop(animated: true)
    }
    
    func detail(_ image: NasaAsset?) {
        let viewModel = DetailViewModelImpl(image)
        viewModel.coordinatior = self
        let controller = DetailController()
        controller.viewModel = viewModel
        navigationController.navigate(to: controller, animated: true)
    }
    
}


