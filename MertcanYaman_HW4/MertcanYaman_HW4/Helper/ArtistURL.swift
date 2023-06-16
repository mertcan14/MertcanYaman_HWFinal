//
//  ArtistURL.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 6.06.2023.
//

import Foundation

enum ArtistURL {
    private var baseURL: String { return "https://itunes.apple.com" }
    private var lookup: String { return "/lookup" }
    
    case id(String)
    case multiId(_ ids: [String])
    
    private var fullPath: String {
        
        var endpoint:String
        switch self {
        case .id(let id):
            endpoint = "?id=\(id)"
        
        case .multiId(let ids):
            let multiId = ids.joined(separator: ",")
            endpoint = "?id=\(multiId)"
        }
        return baseURL + lookup + endpoint
    }
    
    var url: URL? {
        guard let url = URL(string: fullPath) else {
            return nil
        }
        return url
    }
}
