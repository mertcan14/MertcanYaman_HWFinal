//
//  HomeInteractor.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import Foundation
import MusicAPI

protocol HomeInteractorProtocol: AnyObject {
    func fetchMusics(_ term: String, _ searchedType: SearchedType)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func getMusics(_ musics: MusicResult)
    func showError(_ error: Error)
}

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func fetchMusics(_ term: String, _ searchedType: SearchedType) {
        MusicService.shared.getSearch(
            term: term,
            searchedType: searchedType,
            country: "tr",
            limit: nil)
        { [weak self] response in
            guard let self else { return }
            switch response {
                
            case .success(let data):
                self.output?.getMusics(data)                
            case .failure(let error):
                self.output?.showError(error)
            }
        }
    }
    
}