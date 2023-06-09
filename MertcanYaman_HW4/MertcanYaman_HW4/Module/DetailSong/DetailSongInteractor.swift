//
//  DetailSongInteractor.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 8.06.2023.
//

import Foundation
import MyCoreData
import CoreData

protocol DetailSongInteractorProtocol {
    func savedMusic(_ entityName: String, _ addObj: [String:Any])
    func fetchSavedMusic()
}

protocol DetailSongInteractorOutputProtocol: AnyObject {
    func checkSavedFunc(_ success: Bool)
    func showError(_ error: String)
}

final class DetailSongInteractor {
    
    var output: DetailSongInteractorOutputProtocol?
    
}

extension DetailSongInteractor: DetailSongInteractorProtocol {
    
    func fetchSavedMusic() {
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        MyCoreDataService.shared.fetchWordHistory(persistentContainer, entityName: "Song") { [weak self] response in
            switch response {
                
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func savedMusic(_ entityName: String, _ addObj: [String:Any]) {
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        MyCoreDataService.shared.addWordHistory(
            persistentContainer: persistentContainer,
            entityName: entityName,
            addObj: addObj
        ) { [weak self] response in
            switch response {

            case .success(let success):
                self?.output?.checkSavedFunc(success)
            case .failure(let error):
                self?.output?.showError(error.message ?? "Error")
            }
        }
    }
    
}
