//
//  NoInternetViewController.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import UIKit

protocol NoInternetViewControllerProtocol: AnyObject {
    func setTimeLabel(_ label: String)
    func hiddenTimeLabel()
    func showTimeLabel()
    func hideLoading()
    func enabledBtn(_ enabled: Bool)
}

final class NoInternetViewController: BaseViewController {
    
    var presenter: NoInternetPresenterProtocol!

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tryAgainBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tryAgainBtnClicked(_ sender: Any) {
        showLoading()
        presenter.checkInternetConnection()
    }

}

extension NoInternetViewController: NoInternetViewControllerProtocol {
    
    func showTimeLabel() {
        DispatchQueue.main.async {
            self.timeLabel.isHidden = false
        }
    }
    
    func enabledBtn(_ enabled: Bool) {
        DispatchQueue.main.async {
            self.tryAgainBtn.isEnabled = enabled
        }
    }
    
    func setTimeLabel(_ label: String) {
        DispatchQueue.main.async {
            self.timeLabel.text = label
        }
    }
    
    func hiddenTimeLabel() {
        DispatchQueue.main.async {
            self.timeLabel.isHidden = true
        }
    }
    
}
