//
//  DetailPlayListRouter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 12.06.2023.
//

import Foundation

enum DetailPlayListRoutes {
    case goPreviousPage
}

protocol DetailPlayListRouterProtocol {
    func navigate(_ route: DetailPlayListRoutes)
}

final class DetailPlayListRouter {
    weak var viewController: DetailPlayListViewController?
    
    static func createModule() -> DetailPlayListViewController {
        let view = DetailPlayListViewController()
        let interactor = DetailPlayListInteractor()
        let router = DetailPlayListRouter()
        let presenter = DetailPlayListPresenter(view, router, interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension DetailPlayListRouter: DetailPlayListRouterProtocol {
    
    func navigate(_ route: DetailPlayListRoutes) {
        switch route {
            
        case .goPreviousPage:
            self.viewController?.navigationController?.popViewController(animated: true)
        }
    }

}
