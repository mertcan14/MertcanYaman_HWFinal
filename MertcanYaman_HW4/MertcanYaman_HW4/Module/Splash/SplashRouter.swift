//
//  SplashRouter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import Foundation
import UIKit

enum SplashRoutes {
    case homeScreen
    case noInternetScreen
}

protocol SplashRouterProtocol: AnyObject {
    func navigate(_ route: SplashRoutes)
}

final class SplashRouter {
    weak var viewController: SplashViewController?
    
    static func createModule() -> SplashViewController {
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(view, router, interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension SplashRouter: SplashRouterProtocol {
    
    func navigate(_ route: SplashRoutes) {
        guard let window = viewController?.view.window else { return }
        switch route {
            
        case .homeScreen:
            let subModules = (
                home: HomeRouter.createModule(),
                playList: PlayListRouter.createModule()
            )
            let tabBarController = TabBarRouter.createModule(usingSubModules: subModules)
            let navigationController = UINavigationController(rootViewController: tabBarController)
            window.rootViewController = navigationController
        case .noInternetScreen:
            let noInternetVC = NoInternetRouter.createModule()
            let navigationController = UINavigationController(rootViewController: noInternetVC)
            window.rootViewController = navigationController
        }
    }
    
}
