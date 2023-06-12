//
//  SongTabBarController.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 11.06.2023.
//

import UIKit

typealias SongTabs = (
    home: UIViewController,
    playList: UIViewController
)

final class SongTabBarController: UITabBarController {
    
    init(tabs: SongTabs) {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [tabs.home, tabs.playList]
        tabBar.backgroundColor = UIColor(hexString: "#050505")
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
