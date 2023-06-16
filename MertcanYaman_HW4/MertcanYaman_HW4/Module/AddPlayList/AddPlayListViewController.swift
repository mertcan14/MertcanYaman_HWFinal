//
//  AddPlayListViewController.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 11.06.2023.
//

import UIKit

protocol AddPlayListViewControllerProtocol: AnyObject, BaseViewControllerProtocol {
    
    func setupNotificationCenter()
    func setupGestureRecognizer()
    
}

final class AddPlayListViewController: BaseViewController {

    var presenter: AddPlayListPresenterProtocol!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var playListTextField: UITextField!
    @IBOutlet weak var backArrowImage: UIImageView!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setAccessiblityIdentifier()
        presenter.viewDidLoad()
        playListTextField.delegate = self
        
    }
    
    @objc func keyboardVisible() {
        
        viewHeightConstraint.constant = 600
        
    }

    @objc func keyboardHidden() {
        
        viewHeightConstraint.constant = 300
        
    }
    
    @objc func back() {
        
        presenter.goPreviousScreen()
        
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        
        presenter.addPlayList(playListTextField.text ?? "")
        
    }
    
}

extension AddPlayListViewController: AddPlayListViewControllerProtocol {
    
    func setupGestureRecognizer() {
        let backTap = UITapGestureRecognizer(target: self, action: #selector(back))
        backArrowImage.addGestureRecognizer(backTap)
    }
    
    func setupNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(AddPlayListViewController.keyboardVisible),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(AddPlayListViewController.keyboardHidden),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }
    
}

extension AddPlayListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(hallname : UITextField!) -> Bool {
        
        hallname.resignFirstResponder()
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
         textField.resignFirstResponder()
         return true
        
    }
    
}

extension AddPlayListViewController {
    
    func setAccessiblityIdentifier() {
        
        playListTextField.accessibilityIdentifier = "playListTextField"
        
    }
    
}
