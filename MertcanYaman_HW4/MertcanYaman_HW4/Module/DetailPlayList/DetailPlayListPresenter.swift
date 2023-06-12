//
//  DetailPlayListPresenter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 12.06.2023.
//

import Foundation
// Using for SavedMusic Object
import MyCoreData

protocol DetailPlayListPresenterProtocol {
    
    var numberOfSavedMusics: Int { get }
    
    func getSavedMusicByIndex(_ index: Int) -> SavedMusic?
    func goOtherPage(_ routes: DetailPlayListRoutes)
    func viewWillAppear()
    func setName(_ name: String)
    func viewDidLoad()
    func getSavedMusicForTableCellByIndex(_ index: Int) -> (String, String, String)?
}

final class DetailPlayListPresenter {
    unowned var view: DetailPlayListViewControllerProtocol
    let router: DetailPlayListRouterProtocol
    let interactor: DetailPlayListInteractorProtocol
    
    var name: String?
    var savedMusics: [SavedMusic] = []
    
    init(
        _ view: DetailPlayListViewControllerProtocol,
        _ router: DetailPlayListRouterProtocol,
        _ interactor: DetailPlayListInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func setName(_ name:String) {
        self.name = name
    }
    
    func viewWillAppear() {
        view.setTitle(name ?? "")
    }
}

extension DetailPlayListPresenter: DetailPlayListPresenterProtocol {
    
    var numberOfSavedMusics: Int {
        self.savedMusics.count
    }
    
    func getSavedMusicByIndex(_ index: Int) -> SavedMusic? {
        savedMusics[safe: index]
    }
    
    func viewDidLoad() {
        guard let name = self.name else { return }
        if name == "Your Favorites" {
            interactor.fetchSavedMusicByListName("")
        }else {
            interactor.fetchSavedMusicByListName(name)
        }
    }
    
    func goOtherPage(_ routes: DetailPlayListRoutes) {
        self.router.navigate(routes)
    }
    
    func getSavedMusicForTableCellByIndex(_ index: Int) -> (String, String, String)? {
        guard let music = savedMusics[safe: index],
              let imageUrl = music.artworkUrl100,
              let title = music.trackName,
              let content = music.artistName else { return nil }
        return (imageUrl, title, content)
    }
    
}

extension DetailPlayListPresenter: DetailPlayListInteractorOutputProtocol {
    
    func getSavedMusic(_ songs: [SavedMusic]) {
        view.hideLoading()
        self.savedMusics = songs
        view.reloadData()
    }

}