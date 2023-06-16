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
    func addSongFromCoreData()
    func setMusic(_ music: Music)
    func setSelectedPlayList(_ indexPath: Int)
    
}

final class AddPlayListPopUpPresenter {
    
    unowned var view: AddPlayListPopUpProtocol
    let interactor: AddPlayListPopUpInteractorProtocol
    var playLists: [PlayListData] = []
    var music: Music?
    var selectedPlayList: String?
    
    init(
        _ view: AddPlayListPopUpProtocol,
        _ interactor: AddPlayListPopUpInteractorProtocol
    ) {
        self.view = view
        self.interactor = interactor
    }
    
}

extension AddPlayListPopUpPresenter: AddPlayListPopUpPresenterProtocol {
    
    func setSelectedPlayList(_ indexPath: Int) {
        
        selectedPlayList = playLists[safe: indexPath]?.name
        
    }
    
    func setMusic(_ music: Music) {
        
        self.music = music
        
    }
    
    func addSongFromCoreData() {
        
        guard let playList = selectedPlayList else { return }
        let addWord: [String: Any] = [
            "artistName": music?.artistName ?? "",
            "artworkUrl100": music?.artworkUrl100 ?? "",
            "playListName": playList,
            "previewUrl": music?.previewURL ?? "",
            "primaryGenreName": music?.primaryGenreName ?? "",
            "trackId": String(music?.trackID ?? 0),
            "trackName": music?.trackName ?? "",
        ]
        interactor.addSong(addWord)
        
    }
    
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
    
    func showAlert(_ error: String) {
        self.view.showAlert("Error", error)
    }
    
    func getPlayList(_ playList: [PlayListData]) {
        
        self.playLists = playList
        view.reloadData()
        
    }
    
}
