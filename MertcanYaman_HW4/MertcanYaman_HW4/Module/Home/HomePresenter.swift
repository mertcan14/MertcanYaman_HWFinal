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
    
    var numberOfMusics: Int {
        return musicCount
    }
    
    // TODO: - safe yap
    func getMusicByIndex(_ index: Int) -> Music? {
        if index >= 0 && index < musicCount {
            return self.musicResult[index]
        }
        return nil
    }
    
    func fetchData(_ term: String, _ type: SearchedType) {
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
