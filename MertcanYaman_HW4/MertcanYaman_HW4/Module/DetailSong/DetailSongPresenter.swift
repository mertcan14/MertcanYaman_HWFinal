//
//  DetailSongPresenter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 8.06.2023.
//

import Foundation

protocol DetailSongPresenterProtocol {
    func setMusic(_ music: Music)
    func viewWillAppear()
    func goPreviousScreen()
    func saveMusicFromCoreData()
    func viewDidAppear()
}

final class DetailSongPresenter {
    
    unowned var view: DetailSongViewControllerProtocol
    let router: DetailSongRouterProtocol
    let interactor: DetailSongInteractorProtocol
    var music: Music?
    
    init(
        _ view: DetailSongViewControllerProtocol,
        _ router: DetailSongRouterProtocol,
        _ interactor: DetailSongInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    private func setSavedMusic() -> [String: Any] {
        let addWord: [String: Any] = [
            "artistName": music?.artistName ?? "",
            "artworkUrl100": music?.artworkUrl100 ?? "",
            "playListName": "",
            "previewUrl": music?.previewURL ?? "",
            "primaryGenreName": music?.primaryGenreName ?? "",
            "trackId": String(music?.trackID ?? 0),
            "trackName": music?.trackName ?? "",
        ]
        return addWord
    }
    
    private func setSavedMusicFromPlayList(_ playListName: String) -> [String: Any] {
        let addWord: [String: Any] = [
            "artistName": music?.artistName ?? "",
            "artworkUrl100": music?.artworkUrl100 ?? "",
            "playListName": playListName,
            "previewUrl": music?.previewURL ?? "",
            "primaryGenreName": music?.primaryGenreName ?? "",
            "trackId": String(music?.trackID ?? 0),
            "trackName": music?.trackName ?? "",
        ]
        return addWord
    }
    
}

extension DetailSongPresenter: DetailSongPresenterProtocol {
    
    func saveMusicFromCoreData() {
        self.interactor.savedMusic("Song", setSavedMusic())
    }
    
    func goPreviousScreen() {
        self.router.navigate(.dismissScreen)
    }

    func viewWillAppear() {
        view.showLoading()
        guard let imageUrl = music?.artworkUrl100,
              let songName = music?.trackName,
              let artistName = music?.artistName else { return }
        var imageUrlParse = imageUrl.split(separator: "/")
        imageUrlParse[imageUrlParse.count - 1] = "500x500bb.jpg"
        guard let url = URL(string: imageUrlParse.joined(separator: "/")) else { return }
        self.view.setupData(url, songName, artistName)
    }
    
    func viewDidAppear() {
        guard let trackId = music?.trackID else { return }
        interactor.checkIsLiked(["trackId": trackId, "playListName": ""])
    }
    
    func setMusic(_ music: Music) {
        self.music = music
    }
    
}

extension DetailSongPresenter: DetailSongInteractorOutputProtocol {
    
    func isLiked(_ success: Bool) {
        self.view.changeHeartIcon(success)
    }
    
    func checkSavedFunc(_ success: Bool) {
        print(success)
    }
    
    func showError(_ error: String) {
        self.view.showAlert("Error", error) {
            print("Error")
        }
    }
    
    
}
