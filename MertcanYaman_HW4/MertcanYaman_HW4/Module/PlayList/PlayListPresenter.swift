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
    func viewWillAppear()
    func fetchPlayList()
    func getPlayListByIndex(_ index: Int) -> PlayListData?
    func goOtherScreen(_ routes: PlayListRoutes)
    func playMusic()
    func setPlayedMusicIndex(_ index: Int)
    func nextSong()
    func previousSong()
}

final class PlayListPresenter {
    unowned var view: PlayListViewControllerProtocol
    let router: PlayListRouterProtocol
    let interactor: PlayListInteractorProtocol
    var isPlaySong: Bool = true
    var playedMusicIndex: Int = 0
    
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
    
    func viewWillAppear() {
        
        if PlaySong.shared.isPlay() {
            guard let music = PlaySong.shared.getMusicForTableCellByIndex(),
                  let url = URL(string: music.0) else { return }
            view.setPlayedSongView((url, music.1), PlaySong.shared.getIndex())
        }else {
            view.playedSongHidden()
        }
        
    }
    
    
    func fetchPlayList() {
        interactor.fetchPlayList()
    }
    
    func goOtherScreen(_ routes: PlayListRoutes) {
        self.router.navigate(routes)
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
    
    func previousSong() {
        PlaySong.shared.goPreviousSong(self.playedMusicIndex)
    }
    
    func nextSong() {
        PlaySong.shared.goNextSong(PlaySong.shared.getIndex())
    }
    
    func setPlayedMusicIndex(_ index: Int) {
        self.playedMusicIndex = index
    }
    
    func playMusic() {
        if !isPlaySong {
            PlaySong.shared.startSong(self.playedMusicIndex)
            isPlaySong = true
        }else {
            PlaySong.shared.stopSong()
            isPlaySong = false
        }
    }
    
}

extension PlayListPresenter: PlayListInteractorOutputProtocol {
    
    func fetchPlayList(_ data: [PlayListData]) {
        self.playList = data
        view.hideLoading()
    }
    
}
