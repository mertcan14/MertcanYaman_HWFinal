//
//  AddPlayListPopUpPresenter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 12.06.2023.
//

import Foundation
import MyCoreData

protocol AddPlayListPopUpPresenterProtocol {
    var numberOfPlayList: Int { get }
    
    func getPlayListNameByIndex(_ index: Int) -> String?
    func viewDidLoad()
}

final class AddPlayListPopUpPresenter {
    
    unowned var view: AddPlayListPopUpProtocol
    let interactor: AddPlayListPopUpInteractorProtocol
    var playLists: [PlayListData] = []
    
    init(
        _ view: AddPlayListPopUpProtocol,
        _ interactor: AddPlayListPopUpInteractorProtocol
    ) {
        self.view = view
        self.interactor = interactor
    }
}

extension AddPlayListPopUpPresenter: AddPlayListPopUpPresenterProtocol {
    
    func viewDidLoad() {
        interactor.fetchPlayList()
    }
    
    var numberOfPlayList: Int {
        playLists.count
    }
    
    func getPlayListNameByIndex(_ index: Int) -> String? {
        playLists[safe: index]?.name
    }
    
}

extension AddPlayListPopUpPresenter: AddPlayListPopUpInteractorOutputProtocol {
    
    func getPlayList(_ playList: [PlayListData]) {
        self.playLists = playList
        view.reloadData()
    }
    
}
