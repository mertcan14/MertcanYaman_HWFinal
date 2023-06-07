//
//  SplashPresenter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import Foundation

protocol SplashPresenterProtocol: AnyObject {
    func viewDidAppear()
}

final class SplashPresenter: SplashPresenterProtocol {
    
    unowned var view: BaseViewControllerProtocol
    let router: SplashRouterProtocol
    let interactor: SplashInteractorProtocol
    
    init(
        _ view: BaseViewControllerProtocol,
        _ router: SplashRouterProtocol,
        _ interactor: SplashInteractorProtocol
    ) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    func viewDidAppear() {
        interactor.checkInternetConnection()
    }
    
}

extension SplashPresenter: SplashInteractorOutputProtocol {
    
    func internetConnection(_ status: Bool) {
        if status {
            DispatchQueue.main.async() {
                self.router.navigate(.homeScreen)
            }
        }else {
            DispatchQueue.main.async() {
                self.router.navigate(.noInternetScreen)
            }
        }
    }
    
}
