//
//  HomePresenter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import Foundation

protocol HomePresenterProtocol {
    
    var numberOfMusics: Int { get }
    
    func fetchData(_ term: String, _ searchedType: SearchedType)
    func getMusicByIndex(_ index: Int) -> Music?
    func getMusicForTableCellByIndex(_ index: Int) -> (String, String, String, Int)?
    func viewDidLoad()
    func viewWillAppear()
    func goDetailSong(_ index: Int)
    func removeSongs()
    func playMusic()
    func setPlayedMusicIndex(_ index: Int)
    func nextSong()
    func previousSong()
}

final class HomePresenter {
    
    unowned var view: HomeViewControllerProtocol
    let router: HomeRouterProtocol
    let interactor: HomeInteractorProtocol
    var musicResult: [Music] = [] {
        didSet {
            self.view.hideLoading()
            self.view.reloadData()
        }
    }
    var musicCount: Int = 0
    var isPlaySong: Bool = true
    var playedMusicIndex: Int = 0
    
    init(
        _ view: HomeViewControllerProtocol,
        _ router: HomeRouterProtocol,
        _ interactor: HomeInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    private func setMusicUrlAndPushPlaySong() {
        PlaySong.shared.setUrls(self.musicResult)
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func previousSong() {
        PlaySong.shared.goPreviousSong(self.playedMusicIndex)
    }
    
    func nextSong() {
        PlaySong.shared.goNextSong(self.playedMusicIndex)
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
    
    func removeSongs() {
        self.musicResult = []
        self.musicCount = 0
    }
    
    func goDetailSong(_ index: Int) {
        guard let song = self.musicResult[safe: index] else { return }
        self.router.navigate(.detailSong(song, index))
    }
    
    func viewDidLoad() {
        
        self.view.setupField()
        self.view.setupTableView()
        
    }
    
    func viewWillAppear() {
        self.view.setWillAppear()
        self.view.hiddenPlayedSong(!(PlaySong.shared.isPlay()))
        view.reloadDataNotification()
    }
    
    func getMusicForTableCellByIndex(_ index: Int) -> (String, String, String, Int)? {
        guard let music = musicResult[safe: index],
              let imageUrl = music.artworkUrl100,
              let title = music.trackName,
              let content = music.artistName else { return nil }
        return (imageUrl, title, content, index)
    }
    
    var numberOfMusics: Int {
        return musicCount
    }
    
    func getMusicByIndex(_ index: Int) -> Music? {
       return musicResult[safe: index]
    }
    
    func fetchData(
        _ term: String,
        _ type: SearchedType
    ) {
        interactor.fetchMusics(term, type)
    }
    
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func goNoInternet() {
        router.navigate(.noInternetScreen)
    }
    
    func getMusics(_ musics: MusicResult) {
        guard let musicResults = musics.results,
              let count = musics.resultCount else { return }
        self.musicResult = musicResults
        self.musicCount = count
        setMusicUrlAndPushPlaySong()
    }
    
    func showError(_ error: Error) {
        self.view.showAlert("Error", error.localizedDescription) {
            self.view.hideLoading()
            print("Hello")
        }
    }
    
}
