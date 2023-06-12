//
//  DetailPlayListInteractor.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 12.06.2023.
//

import Foundation
import MyCoreData

protocol DetailPlayListInteractorProtocol {
    func fetchSavedMusicByListName(_ listName: String)
}

protocol DetailPlayListInteractorOutputProtocol {
    func getSavedMusic(_ songs: [SavedMusic])
}

final class DetailPlayListInteractor {
    var output: DetailPlayListInteractorOutputProtocol?
}

extension DetailPlayListInteractor: DetailPlayListInteractorProtocol {
    
    func fetchSavedMusicByListName(_ listName: String) {
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        MyCoreDataService.shared.fetchMusic(persistentContainer, listName) { [weak self] response in
            guard let self else { return }
            switch response {
                
            case .success(let data):
                self.output?.getSavedMusic(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
