//
//  MockHomeInteractor.swift
//  MertcanYaman_HW4Tests
//
//  Created by mertcan YAMAN on 15.06.2023.
//

import Foundation
@testable import MertcanYaman_HW4

final class MockHomeInteractor: HomeInteractorProtocol {
    
    var isInvokedFetchMusic = false
    var invokedFetchMusicCount = 0
    var invokedFetchMusicsParameters: (term:String, Void)?
    
    func fetchMusics(_ term: String) {
        self.invokedFetchMusicCount += 1
        self.isInvokedFetchMusic = true
        self.invokedFetchMusicsParameters = (term, ())
    }
    
}
