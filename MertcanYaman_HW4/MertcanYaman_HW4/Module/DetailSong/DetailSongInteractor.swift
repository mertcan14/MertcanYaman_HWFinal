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
    func fetchPlayList()
    func checkIsLiked(_ addObj: [String:Any])
}

protocol DetailSongInteractorOutputProtocol: AnyObject {
    func checkSavedFunc(_ success: Bool)
    func showError(_ error: String)
    func isLiked(_ success: Bool)
}

final class DetailSongInteractor {
    
    var output: DetailSongInteractorOutputProtocol?
    
}

extension DetailSongInteractor: DetailSongInteractorProtocol {
    
    func checkIsLiked(_ addObj: [String : Any]) {
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        MyCoreDataService.shared.checkObject(persistentContainer, entityName: "Song", checkAttribute: addObj) { [weak self] response in
            guard let self else { return }
            switch response {
                
            case .success(let data):
                self.output?.isLiked(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPlayList() {
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        MyCoreDataService.shared.fetchPlayList(persistentContainer) { [weak self] response in
            guard let self else { return }
            switch response {
                
            case .success(let data):
                print(data.count)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func savedMusic(_ entityName: String, _ addObj: [String:Any]) {
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        MyCoreDataService.shared.addObj(
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
        var addObj = [
            "name": "Populer"
        ]
        MyCoreDataService.shared.addObj(
            persistentContainer: persistentContainer,
            entityName: "PlayList",
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
