//
//  MyCoreDataService.swift
//  
//
//  Created by mertcan YAMAN on 1.06.2023.
//

import Foundation
import CoreData

public enum CoreDataError: Error {
    case operationFailed
    case maxObjectNegative
    case emptyValue
    case error(Error)
    
    public var message: String? {
        switch self {
        case .operationFailed:
            return "We encountered an unexpected error"
        case .maxObjectNegative:
            return "The value to be returned cannot be negative."
        case .emptyValue:
            return "Searched data not found"
        case .error(let error):
            return error.localizedDescription
        }
    }
}

public class MyCoreDataService {
    public static let shared = MyCoreDataService()
    /// Fetch data from Core Data
    public func fetchMusic(_ persistentContainer: NSPersistentContainer,
                                 completion: @escaping (Result<[SavedMusic], CoreDataError>) -> Void)
    {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Song")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                var musics: [SavedMusic] = []
                for result in results as! [NSManagedObject] {
                    let artistName = result.value(forKey: "artistName") as? String ?? nil
                    let artworkUrl100 = result.value(forKey: "artworkUrl100") as? String ?? nil
                    let playlistName = result.value(forKey: "playListName") as? String ?? nil
                    let previewUrl = result.value(forKey: "previewUrl") as? String ?? nil
                    let primaryGenreName = result.value(forKey: "primaryGenreName") as? String ?? nil
                    let trackId = result.value(forKey: "trackId") as? String ?? nil
                    let trackName = result.value(forKey: "trackName") as? String ?? nil
                    
                    let music = SavedMusic(
                        artistName: artistName,
                        artworkUrl100: artworkUrl100,
                        playListName: playlistName,
                        previewUrl: previewUrl,
                        primaryGenreName: primaryGenreName,
                        trackId: trackId,
                        trackName: trackName)
                    musics.append(music)
                }
                completion(.success(musics))
            }
        }catch {
            completion(.failure(.operationFailed))
        }
    }
    
    public func fetchPlayList(_ persistentContainer: NSPersistentContainer,
                                 completion: @escaping (Result<[PlayListData], CoreDataError>) -> Void)
    {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayList")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                var playLists: [PlayListData] = []
                for result in results as! [NSManagedObject] {
                    let name = result.value(forKey: "name") as? String ?? nil
                    
                    let playList = PlayListData(name: name)
                    playLists.append(playList)
                }
                completion(.success(playLists))
            }else {
                completion(.success([]))
            }
        }catch {
            completion(.failure(.operationFailed))
        }
    }
    
    /// Add data from Core Data 
    public func addObj( persistentContainer: NSPersistentContainer,
                                entityName: String,
                                addObj: [String:Any],
                                completion: @escaping (Result<Bool, CoreDataError>) -> Void) {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let wordHistory = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        addObj.keys.forEach { key in
            wordHistory.setValue(addObj[key], forKey: key)
        }
        do {
            try context.save()
            completion(.success(true))
        }catch {
            completion(.failure(.operationFailed))
        }
    }
    
    /// Returns Row if word is already inserted, returns nil if there is no row
    public func checkObject(_ persistentContainer: NSPersistentContainer,
                                  entityName: String,
                                 checkAttribute: [String:Any],
                                 completion: @escaping (Result<Bool, CoreDataError>) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var keys: [String:NSPredicate] = [:]
        
        for key in checkAttribute.keys {
            keys[key] = NSPredicate(format: "\(key) = %@", "\(checkAttribute[key] ?? "")")
        }
        
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: keys.values.map({ predicate in
            return predicate
        }))
        
        fetchRequest.predicate = predicate
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                completion(.success(true))
            }else {
                completion(.success(false))
            }
        }catch {
            completion(.failure(.operationFailed))
        }
    }
}
