//
//  PlayListPresenter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 10.06.2023.
//

import Foundation
// Using for SavedMusic Object
import MyCoreData

protocol PlayListPresenterProtocol {
    
    var numberOfPlayList: Int { get }
    
    func viewDidLoad()
    func fetchPlayList()
    func getPlayListByIndex(_ index: Int) -> PlayListData?
    func goAddPlayListScreen()
}

final class PlayListPresenter {
    unowned var view: PlayListViewControllerProtocol
    let router: PlayListRouterProtocol
    let interactor: PlayListInteractorProtocol
    
    var playList: [PlayListData] = [] {
        didSet {
            view.reloadData()
        }
    }
    
    init(view: PlayListViewControllerProtocol, router: PlayListRouterProtocol, interactor: PlayListInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension PlayListPresenter: PlayListPresenterProtocol {
    
    func fetchPlayList() {
        interactor.fetchPlayList()
    }
    
    func goAddPlayListScreen() {
        router.navigate(.addPlayList)
    }
    
    func getPlayListByIndex(_ index: Int) -> PlayListData? {
        playList[safe: index]
    }
    
    var numberOfPlayList: Int {
        playList.count + 1
    }
    
    func viewDidLoad() {
        view.setTableView()
    }
    
}

extension PlayListPresenter: PlayListInteractorOutputProtocol {
    
    func fetchPlayList(_ data: [PlayListData]) {
        self.playList = data
        view.hideLoading()
    }
    
}
