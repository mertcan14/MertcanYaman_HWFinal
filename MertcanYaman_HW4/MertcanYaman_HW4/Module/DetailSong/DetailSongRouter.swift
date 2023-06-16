//
//  DetailSongRouter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 8.06.2023.
//

import Foundation

enum DetailSongRoutes {
    
    case dismissScreen
    
}

protocol DetailSongRouterProtocol: AnyObject {
    
    func navigate(_ route: DetailSongRoutes)
    
}

final class DetailSongRouter {
    
    weak var viewController: DetailSongViewController?
    
    static func createModule() -> DetailSongViewController {
        let view = DetailSongViewController()
        let interactor = DetailSongInteractor()
        let router = DetailSongRouter()
        let presenter = DetailSongPresenter(view, router, interactor)
        interactor.output = presenter
        router.viewController = view
        view.presenter = presenter
        return view
    }
    
}

extension DetailSongRouter: DetailSongRouterProtocol {
    
    func navigate(_ route: DetailSongRoutes) {
        switch route {
            
        case .dismissScreen:
            self.viewController?.navigationController?.popViewController(animated: true)
        }
    }

}
