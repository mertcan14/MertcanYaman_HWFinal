//
//  AddPlayListInteractor.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 11.06.2023.
//

import Foundation
import MyCoreData

protocol AddPlayListInteractorProtocol {
    
    func addPlayList(_ name: String)
    
}

protocol AddPlayListInteractorOutputProtocol {
    
    func successAddPlayList(_ success: Bool)
    func showError(_ error: String)
    
}

final class AddPlayListInteractor {
    
    var output: AddPlayListInteractorOutputProtocol?
    
}

extension AddPlayListInteractor: AddPlayListInteractorProtocol {
    
    func addPlayList(_ name: String) {
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        MyCoreDataService.shared.addObj(
            persistentContainer: persistentContainer,
            entityName: "PlayList",
            addObj: ["name": name]
        ) { [weak self] response in
            guard let self else { return }
            switch response {
                
            case .success(let success):
                self.output?.successAddPlayList(success)
            case .failure(let error):
                self.output?.showError(error.message ?? "Error")
            }
        }
    }
    
}
