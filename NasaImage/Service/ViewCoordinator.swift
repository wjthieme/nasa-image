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
    func detail()
}

class ViewCoordinatorImpl: ViewCoordinator {
    var navigationController: NavigationController
    
    init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
        overview()
    }
    
    func overview() {
        let controller = OverviewControllerImpl(OverviewViewModelImpl())
        controller.viewModel.coordinatior = self
        navigationController.navigate(to: controller, animated: true)
    }
    
    func detail() {
        let controller = DetailControllerImpl(DetailViewModelImpl())
        controller.viewModel.coordinatior = self
        navigationController.navigate(to: controller, animated: true)
    }
    
}


