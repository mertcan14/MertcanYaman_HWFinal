//
//  AddPlayListPopUpInteractor.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 12.06.2023.
//

import Foundation
import MyCoreData

protocol AddPlayListPopUpInteractorProtocol {
    
    func fetchPlayList()
    func addSong(_ addObj: [String:Any])
    
}

protocol AddPlayListPopUpInteractorOutputProtocol {
    
    func getPlayList(_ playList: [PlayListData])
    func showAlert(_ error: String)
    
}

final class AddPlayListPopUpInteractor {
    
    var output: AddPlayListPopUpInteractorOutputProtocol?
    
}

extension AddPlayListPopUpInteractor: AddPlayListPopUpInteractorProtocol {
    
    func addSong(_ addObj: [String : Any]) {
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        MyCoreDataService.shared.addObj(
            persistentContainer: persistentContainer,
            entityName: "Song",
            addObj: addObj
        ) { [weak self] response in
            
            guard let self else { return }
            switch response {
            case .success(let success):
                if !success {
                    self.output?.showAlert("An unexpected error has occurred")
                }
            case .failure(let error):
                self.output?.showAlert(error.message ?? "Error")
            }
            
        }
    }
    
    func fetchPlayList() {
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        MyCoreDataService.shared.fetchPlayList(persistentContainer)
        { [weak self] response in
            guard let self else { return }
            switch response {
                
            case .success(let data):
                self.output?.getPlayList(data)
            case .failure(let error):
                self.output?.showAlert(error.message ?? "Error")
            }
        }
    }
    
}
