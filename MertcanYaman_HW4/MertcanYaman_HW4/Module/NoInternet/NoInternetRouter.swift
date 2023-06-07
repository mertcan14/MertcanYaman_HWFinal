//
//  NoInternetRouter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import Foundation
import UIKit

enum NoInternetRoutes {
    case homeScreen
}

protocol NoInternetRouterProtocol: AnyObject {
    func navigate(_ route: NoInternetRoutes)
}

final class NoInternetRouter {
    weak var viewController: NoInternetViewController?
    
    static func createModule() -> NoInternetViewController {
        let view = NoInternetViewController()
        let interactor = NoInternetInteractor()
        let router = NoInternetRouter()
        let presenter = NoInternetPresenter(view, router, interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension NoInternetRouter: NoInternetRouterProtocol {
    
    func navigate(_ route: NoInternetRoutes) {
        guard let window = viewController?.view.window else { return }
        switch route {
            
        case .homeScreen:
            let homeVC = HomeRouter.createModule()
            let navigationController = UINavigationController(rootViewController: homeVC)
            window.rootViewController = navigationController
        }
    }
    
}
