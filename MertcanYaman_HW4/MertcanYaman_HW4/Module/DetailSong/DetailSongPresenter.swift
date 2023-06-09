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
    
}

extension DetailSongPresenter: DetailSongPresenterProtocol {
    
    func goPreviousScreen() {
        self.router.navigate(.dismissScreen)
    }
    
    func viewWillAppear() {
        guard let imageUrl = music?.artworkUrl100,
              let songName = music?.trackName,
              let artistName = music?.artistName else { return }
        var imageUrlParse = imageUrl.split(separator: "/")
        imageUrlParse[imageUrlParse.count - 1] = "500x500bb.jpg"
        guard let url = URL(string: imageUrlParse.joined(separator: "/")) else { return }
        self.view.setupData(url, songName, artistName)
    }
    
    func setMusic(_ music: Music) {
        self.music = music
    }
    
}

extension DetailSongPresenter: DetailSongInteractorOutputProtocol {
    
}
