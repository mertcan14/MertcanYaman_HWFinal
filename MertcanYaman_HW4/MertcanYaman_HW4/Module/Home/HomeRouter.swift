//
//  HomeRouter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import Foundation
import UIKit

enum HomeRoutes {
    case noInternetScreen
    case detailSong(_ song: Music)
}

protocol HomeRouterProtocol: AnyObject {
    func navigate(_ route: HomeRoutes)
}

final class HomeRouter {
    weak var viewController: HomeViewController?
    
    static func createModule() -> HomeViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(view, router, interactor)
        interactor.output = presenter
        router.viewController = view
        view.presenter = presenter
        return view
    }
}

extension HomeRouter: HomeRouterProtocol {
    
    func navigate(_ route: HomeRoutes) {
        guard let window = viewController?.view.window else { return }
        switch route {
            
        case .noInternetScreen:
            let noInternetVC = NoInternetRouter.createModule()
            let navigationController = UINavigationController(rootViewController: noInternetVC)
            window.rootViewController = navigationController
            
        case .detailSong(let music):
            let detailSongVC = DetailSongRouter.createModule()
            detailSongVC.presenter.setMusic(music)
//            detailSongVC.modalPresentationStyle = .fullScreen
//            detailSongVC.modalTransitionStyle = .coverVertical
//            self.viewController?.present(detailSongVC, animated: true)
            
//            let navigationController = UINavigationController(rootViewController: detailSongVC)
//            window.rootViewController = navigationController
            viewController?.navigationController?.pushViewController(detailSongVC, animated: true)
        }
        
    }
}