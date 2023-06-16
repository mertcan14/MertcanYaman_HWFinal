//
//  DetailSongInteractor.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 8.06.2023.
//

import Foundation
import MyCoreData

protocol DetailSongInteractorProtocol {
    
    func savedMusic(_ entityName: String, _ addObj: [String:Any])
    func removeSaveMusic(_ entityName: String, _ removeObj: [String:Any])
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
    
    func removeSaveMusic(_ entityName: String, _ removeObj: [String:Any]) {
        
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        MyCoreDataService.shared.deleteMusic(
            persistentContainer,
            removeObj
        ) { [weak self] response in
            guard let self else { return }
            switch response {
                
            case .success(_):
                break
            case .failure(let error):
                self.output?.showError(error.message ?? "Error")
            }
        }
        
    }
    
    func checkIsLiked(_ addObj: [String : Any]) {
        
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        MyCoreDataService.shared.checkObject(
            persistentContainer,
            entityName: "Song",
            checkAttribute: addObj
        ) { [weak self] response in
            guard let self else { return }
            switch response {
                
            case .success(let data):
                self.output?.isLiked(data)
            case .failure(let error):
                self.output?.showError(error.message ?? "Error")
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
        
    }
    
}
