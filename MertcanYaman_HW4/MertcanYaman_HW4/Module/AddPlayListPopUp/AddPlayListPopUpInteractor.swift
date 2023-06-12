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
}

protocol AddPlayListPopUpInteractorOutputProtocol {
    func getPlayList(_ playList: [PlayListData])
}

final class AddPlayListPopUpInteractor {
    var output: AddPlayListPopUpInteractorOutputProtocol?
}

extension AddPlayListPopUpInteractor: AddPlayListPopUpInteractorProtocol {
    func fetchPlayList() {
        guard let persistentContainer = CoreDataReturnPersistentContainer.shared.persistentContainer else { return }
        MyCoreDataService.shared.fetchPlayList(persistentContainer) { [weak self] response in
            guard let self else { return }
            switch response {
                
            case .success(let data):
                self.output?.getPlayList(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
