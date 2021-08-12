//
//  DetailController.swift
//  NasaImage
//
//  Created by Wilhelm Thieme on 12/08/2021.
//

import UIKit

class DetailController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var viewModel: DetailViewModel = DetailViewModelImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
}
