//
//  BaseViewController.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import UIKit

protocol BaseViewControllerProtocol: AnyObject, LoadingShowable {
    func showAlert(
        _ title: String,
        _ message: String,
        _ action: (() -> Void)?
    )
}

class BaseViewController: UIViewController, LoadingShowable {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension BaseViewController: BaseViewControllerProtocol {
    
    func showAlert(
        _ title: String,
        _ message: String,
        _ action: (() -> Void)?
    ) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { alertAction in
            guard let action else { return }
            action()
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
        
    }
    
}
