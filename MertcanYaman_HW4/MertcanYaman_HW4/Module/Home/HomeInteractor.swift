//
//  HomeInteractor.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import Foundation
import MusicAPI

protocol HomeInteractorProtocol: AnyObject {
    func fetchMusics(_ term: String)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func getMusics(_ musics: MusicResult)
    func showError(_ error: Error)
    func goNoInternet()
}

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func fetchMusics(_ term: String) {
        MusicService.shared.getSearch(
            term: term,
            searchedType: .song,
            country: "tr",
            limit: nil)
        { [weak self] response in
            guard let self else { return }
            switch response {
                
            case .success(let data):
                self.output?.getMusics(data)                
            case .failure(let error):
                if error.message == NetworkError.connectionError.message {
                    self.output?.goNoInternet()
                }else {
                    print(error)
                }
            }
        }
    }
    
}
