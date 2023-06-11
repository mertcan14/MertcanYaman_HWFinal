//
//  AddPlayListViewController.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 11.06.2023.
//

import UIKit

protocol AddPlayListViewControllerProtocol: AnyObject, BaseViewControllerProtocol {
    
}

final class AddPlayListViewController: BaseViewController {

    var presenter: AddPlayListPresenterProtocol!
    
    @IBOutlet weak var backArrowImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backTap = UITapGestureRecognizer(target: self, action: #selector(back))
        backArrowImage.addGestureRecognizer(backTap)
    }
    
    @objc func back() {
        presenter.goPreviousScreen()
    }
}

extension AddPlayListViewController: AddPlayListViewControllerProtocol{
    
}
