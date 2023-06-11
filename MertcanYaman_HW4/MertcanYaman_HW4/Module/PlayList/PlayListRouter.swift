//
//  PlayListRouter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 10.06.2023.
//

import Foundation

enum PlayListRoutes {
    case detailSong
    case addPlayList
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
            
        case .detailSong:
            break
        case .addPlayList:
            let addPlayListVC = AddPlayListRouter.createModule()
            viewController?.navigationController?.pushViewController(addPlayListVC, animated: true)
        }
    }
    
}
