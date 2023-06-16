//
//  TabBarRouter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 11.06.2023.
//

import UIKit

typealias Submodules = (
    home: UIViewController,
    playList: UIViewController
)

protocol TapBarRouterProtocol: AnyObject {
    
    static func tabs(usingSubModules submodules: Submodules) -> SongTabs
    
}

final class TabBarRouter {
    
    var viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func createModule(usingSubModules subModules: Submodules) -> UITabBarController {
        let tabs = TabBarRouter.tabs(usingSubModules: subModules)
        let tabBarController = SongTabBarController(tabs: tabs)
        return tabBarController
    }
    
}

extension TabBarRouter: TapBarRouterProtocol {
    
    static func tabs(usingSubModules submodules: Submodules) -> SongTabs {
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 11)
        let playListTabBarItem = UITabBarItem(title: "Play List", image: UIImage(named: "playlist"), tag: 11)
        
        submodules.home.tabBarItem = homeTabBarItem
        submodules.playList.tabBarItem = playListTabBarItem
        
        return (
            home: submodules.home,
            playList: submodules.playList
        )
    }
    
}
