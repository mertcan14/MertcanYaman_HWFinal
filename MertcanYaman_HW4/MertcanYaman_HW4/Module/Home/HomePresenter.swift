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
    func getMusicForTableCellByIndex(_ index: Int) -> (String, String, String)?
    func viewDidLoad()
    func viewWillAppear()
    func goDetailSong(_ index: Int)
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
    var artistResult: [Artist] = [] {
        didSet {
            self.view.hideLoading()
            self.view.reloadData()
        }
    }
    var musicCount: Int = 0
    
    init(
        _ view: HomeViewControllerProtocol,
        _ router: HomeRouterProtocol,
        _ interactor: HomeInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func goDetailSong(_ index: Int) {
        guard let song = self.musicResult[safe: index] else { return }
        self.router.navigate(.detailSong(song))
    }
    
    func viewDidLoad() {
        
        self.view.setupField()
        self.view.setupTableView()
        
    }
    
    func viewWillAppear() {
        self.view.setWillAppear()
    }
    
    func getMusicForTableCellByIndex(_ index: Int) -> (String, String, String)? {
        guard let music = musicResult[safe: index],
              let imageUrl = music.artworkUrl100,
              let title = music.trackName,
              let content = music.artistName else { return nil }
        return (imageUrl, title, content)
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
    
    func getMusics(_ musics: MusicResult) {
        guard let musicResults = musics.results,
              let count = musics.resultCount else { return }
        self.musicResult = musicResults
        self.musicCount = count
    }
    
    func showError(_ error: Error) {
        self.view.showAlert("Error", error.localizedDescription) {
            self.view.hideLoading()
            print("Hello")
        }
    }
    
}
