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
    
    func addPlayList(_ name: String) {
        interactor.addPlayList(name)
    }
    
    func goPreviousScreen() {
        router.navigate(.goPreviousPage)
    }
    
}

extension AddPlayListPresenter: AddPlayListInteractorOutputProtocol {
    
    func successAddPlayList(_ success: Bool) {
        if success {
            router.navigate(.goPreviousPage)
        }
    }
    
}