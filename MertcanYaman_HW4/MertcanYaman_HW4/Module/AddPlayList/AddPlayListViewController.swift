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
    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var playListTextField: UITextField!
    @IBOutlet weak var backArrowImage: UIImageView!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAccessiblityIdentifier()
        playListTextField.delegate = self
        let backTap = UITapGestureRecognizer(target: self, action: #selector(back))
        backArrowImage.addGestureRecognizer(backTap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddPlayListViewController.keyboardVisible), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddPlayListViewController.keyboardHidden), name: UIResponder.keyboardDidHideNotification, object: nil)

        
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

extension AddPlayListViewController: AddPlayListViewControllerProtocol{
    
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
