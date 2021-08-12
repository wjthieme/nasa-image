//
//  DetailController.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

protocol DetailController: UIViewController {
    var viewModel: DetailViewModel { get  }
}


class DetailControllerImpl: UIViewController, DetailController {
    let viewModel: DetailViewModel
    
    
    init(_ viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.bind(self)
    }
    
}
