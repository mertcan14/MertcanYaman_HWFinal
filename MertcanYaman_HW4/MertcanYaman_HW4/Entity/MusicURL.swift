//
//  MusicURL.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 6.06.2023.
//

import Foundation

enum MusicURL {
    private var baseURL: String { return "https://itunes.apple.com" }
    private var search: String { return "/search" }
    
    case param(String,Dictionary<String, String>)
    
    init(
        term: String,
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
        self = .param(term, paramsDict)
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
        guard let url = URL(string: fullPath) else {
            return nil
        }
        return url
    }
}

