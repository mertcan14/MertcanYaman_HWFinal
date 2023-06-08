//
//  DetailSongInteractor.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 8.06.2023.
//

import Foundation

protocol DetailSongInteractorProtocol {
    
}

protocol DetailSongInteractorOutputProtocol: AnyObject {
    
}

final class DetailSongInteractor {
    
    var output: DetailSongInteractorOutputProtocol?
    
}

extension DetailSongInteractor: DetailSongInteractorProtocol {
    
}
