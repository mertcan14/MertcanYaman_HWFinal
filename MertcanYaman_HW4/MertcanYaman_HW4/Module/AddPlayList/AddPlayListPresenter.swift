//
//  AddPlayListPresenter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 11.06.2023.
//

import Foundation

protocol AddPlayListPresenterProtocol {
    
    func goPreviousScreen()
    func addPlayList(_ name: String)
    func viewDidLoad()
    
}

final class AddPlayListPresenter {
    
    unowned var view: AddPlayListViewControllerProtocol
    let router: AddPlayListRouterProtocol
    let interactor: AddPlayListInteractorProtocol
    
    init(
        view: AddPlayListViewControllerProtocol,
        router: AddPlayListRouterProtocol,
        interactor: AddPlayListInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension AddPlayListPresenter: AddPlayListPresenterProtocol {
    
    func viewDidLoad() {
        
        self.view.setupNotificationCenter()
        self.view.setupGestureRecognizer()
        
    }
    
    func addPlayList(_ name: String) {
        
        let nameCount = name.count
        if nameCount >= 2 && nameCount <= 50 {
            interactor.addPlayList(name)
        }else {
            view.showAlert("Play List Name", "Name must be between 2 and 50 characters", nil)
        }
        
    }
    
    func goPreviousScreen() {
        
        router.navigate(.goPreviousPage)
        
    }
    
}

extension AddPlayListPresenter: AddPlayListInteractorOutputProtocol {
    
    func showError(_ error: String) {
        
        self.view.showAlert("Error", error, nil)
        
    }
    
    func successAddPlayList(_ success: Bool) {
        
        if success {
            router.navigate(.goPreviousPage)
        }
        
    }
    
}
