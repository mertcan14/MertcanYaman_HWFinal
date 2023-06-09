//
//  CoreDataReturnPersistentContainer.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 10.06.2023.
//

import Foundation
import UIKit
import CoreData

final class CoreDataReturnPersistentContainer {
    
    static let shared = CoreDataReturnPersistentContainer()
    
    var persistentContainer: NSPersistentContainer?
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        self.persistentContainer = appDelegate.persistentContainer
    }
    
}
