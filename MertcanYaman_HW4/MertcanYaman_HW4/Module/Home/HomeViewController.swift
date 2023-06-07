//
//  HomeViewController.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    
}

final class HomeViewController: BaseViewController {

    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    
}
