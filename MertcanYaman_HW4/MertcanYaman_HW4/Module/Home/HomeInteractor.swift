//
//  HomeInteractor.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import Foundation

protocol HomeInteractorProtocol: AnyObject {
    
}

protocol HomeInteractorOutputProtocol: AnyObject {
    
}

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    
}
