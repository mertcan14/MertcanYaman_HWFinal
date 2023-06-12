//
//  MusicAPI+Extension.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 6.06.2023.
//

import Foundation
import MusicAPI


// MARK: - Extension Music Service For Artist
extension MusicService {
    
    func getArtistById(
        _ id: String,
        completion: @escaping ((Result<ArtistResult, NetworkError>) -> Void)
    ) {
        if ReachabilityService.isConnectedToInternet() {
            guard let url = ArtistURL.id(id).url else {
                completion(.failure(.invalidChar))
                return
            }
            self.fetchMusic(url, completion: completion)
        }else {
            completion(.failure(.connectionError))
        }
    }
    
    func getArtistsByIds(
        _ ids: String...,
        completion: @escaping ((Result<ArtistResult, NetworkError>) -> Void)
    ) {
        if ReachabilityService.isConnectedToInternet() {
            guard let url = ArtistURL.multiId(ids).url else {
                completion(.failure(.invalidChar))
                return
            }
            self.fetchMusic(url, completion: completion)
        }else {
            completion(.failure(.connectionError))
        }
    }
    
}

// MARK: - Extension Music Service For Music
extension MusicService {
    
    func getSearch(
        term: String,
        searchedType: SearchedType,
        country: String?,
        limit: String?,
        completion: @escaping ((Result<MusicResult, NetworkError>) -> Void)
    ) {
        if ReachabilityService.isConnectedToInternet() {
            guard let url = MusicURL(term: term, searchedType: searchedType, country: country, limit: limit).url else {
                completion(.failure(.invalidChar))
                return
            }
            self.fetchMusic(url, completion: completion)
        }else {
            completion(.failure(.connectionError))
        }
    }
    
}
