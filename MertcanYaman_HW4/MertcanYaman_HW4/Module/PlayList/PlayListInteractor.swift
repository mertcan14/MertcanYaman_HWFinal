//
//  PlayListInteractor.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 10.06.2023.
//

import Foundation
import MyCoreData

protocol PlayListInteractorProtocol {
    func fetchPlayList()
}

protocol PlayListInteractorOutputProtocol {
    func fetchPlayList(_ data: [PlayListData])
}

final class PlayListInteractor {
    var output: PlayListInteractorOutputProtocol?
}

extension PlayListInteractor: PlayListInteractorProtocol {
    
    func fetchPlayList() {
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        MyCoreDataService.shared.fetchPlayList(persistentContainer, completion: { [weak self] response in
            switch response {
                
            case .success(let data):
                self?.output?.fetchPlayList(data)
            case .failure(let error):
                print(error)
            }
        })
    }
    
}
