//
//  MockHomeRouter.swift
//  MertcanYaman_HW4Tests
//
//  Created by mertcan YAMAN on 15.06.2023.
//

import Foundation
@testable import MertcanYaman_HW4

final class MockHomeRouter: HomeRouterProtocol {
    
    var isInvokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (route: HomeRoutes, Void)?
    
    func navigate(_ route: MertcanYaman_HW4.HomeRoutes) {
        self.isInvokedNavigate = true
        self.invokedNavigateCount += 1
        self.invokedNavigateParameters = (route,())
    }
    
}
