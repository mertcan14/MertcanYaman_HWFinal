//
//  MusicURL.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 6.06.2023.
//

import Foundation

enum SearchedType: String {
    case song = "song"
    case album = "album"
    case artist = "allArtist"
    case all = "all"
}

enum MusicURL {
    private var baseURL: String { return "https://itunes.apple.com" }
    private var search: String { return "/search" }
    
    case param(String ,Dictionary<String, String>)
    
    init(
        term: String,
        searchedType: SearchedType,
        country: String?,
        limit: String?
    ) {
        var paramsDict: [String:String] = [:]
        if let country {
            paramsDict["country"] = country
        }
        if let limit {
            paramsDict["limit"] = limit
        }
        if searchedType != .all {
            paramsDict["entity"] = searchedType.rawValue
        }
        let termArray = term.split(separator: " ")
        self = .param(termArray.joined(separator: "+"), paramsDict)
    }
    
    private var fullPath: String {
        
        var endpoint:String = ""
        switch self {
        case .param(let term, let params):
            endpoint = "?term=\(term)"
            for key in params.keys {
                guard let value = params[key] else { break }
                endpoint += "&\(key)=\(value)"
            }
        }
        return baseURL + search + endpoint
    }
    
    var url: URL? {
        guard let url = URL(string: fullPath.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!) else {
            return nil
        }
        return url
    }
}

