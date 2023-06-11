//
//  AddPlayListRouter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 11.06.2023.
//

import Foundation

enum AddPlayListRoutes {
    case goPreviousPage
}

protocol AddPlayListRouterProtocol {
    func navigate(_ route: AddPlayListRoutes)
}

final class AddPlayListRouter {
    weak var viewController: AddPlayListViewController?
    
    static func createModule() -> AddPlayListViewController {
        let view = AddPlayListViewController()
        let interactor = AddPlayListInteractor()
        let router = AddPlayListRouter()
        let presenter = AddPlayListPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension AddPlayListRouter: AddPlayListRouterProtocol{
    
    func navigate(_ route: AddPlayListRoutes) {
        switch route {
            
        case .goPreviousPage:
            self.viewController?.navigationController?.popViewController(animated: true)
        }
    }
    
}
