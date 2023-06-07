//
//  NoInternetInteractor.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import Foundation
import MusicAPI

protocol NoInternetInteractorProtocol {
    func checkInternetConnection()
}

protocol NoInternetInteractorOutputProtocol {
    func internetConnection(_ status: Bool)
}

final class NoInternetInteractor {
    var output: NoInternetInteractorOutputProtocol?
}

extension NoInternetInteractor: NoInternetInteractorProtocol {
    
    func checkInternetConnection() {
        self.output?.internetConnection(ReachabilityService.isConnectedToInternet())
    }
    
}


