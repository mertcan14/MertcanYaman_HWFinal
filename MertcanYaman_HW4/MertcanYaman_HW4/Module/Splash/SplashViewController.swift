//
//  SplashViewController.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import UIKit

final class SplashViewController: BaseViewController {

    var presenter: SplashPresenterProtocol!
    
    @IBOutlet weak var splahImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        presenter.viewDidAppear()
    }
}
