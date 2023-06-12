//
//  PlayListRouter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 10.06.2023.
//

import Foundation

enum PlayListRoutes {
    case addPlayList
    case detailPlayList(_ name: String)
}

protocol PlayListRouterProtocol: AnyObject {
    func navigate(_ route: PlayListRoutes)
}

final class PlayListRouter {
    weak var viewController: PlayListViewController?
    
    static func createModule() -> PlayListViewController {
        let view = PlayListViewController()
        let interactor = PlayListInteractor()
        let router = PlayListRouter()
        let presenter = PlayListPresenter(view: view, router: router, interactor: interactor)
        interactor.output = presenter
        router.viewController = view
        view.presenter = presenter
        return view
    }
}


extension PlayListRouter: PlayListRouterProtocol {
    
    func navigate(_ route: PlayListRoutes) {
        switch route {
            
        case .detailPlayList(let name):
            let detailPlayListVC = DetailPlayListRouter.createModule()
            detailPlayListVC.presenter.setName(name)
            viewController?.navigationController?.pushViewController(detailPlayListVC, animated: true)
        case .addPlayList:
            let addPlayListVC = AddPlayListRouter.createModule()
            viewController?.navigationController?.pushViewController(addPlayListVC, animated: true)
        }
    }
    
}
