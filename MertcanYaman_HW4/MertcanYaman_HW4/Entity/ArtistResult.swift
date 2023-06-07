//
//  ArtistResult.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 6.06.2023.
//

import Foundation

struct ArtistResult: Decodable {
    let resultCount: Int?
    let results: [Artist]?
}

struct Artist: Decodable {
    let wrapperType, artistType, artistName: String?
    let artistLinkURL: String?
    let artistID, amgArtistID: Int?
    let primaryGenreName: String?
    let primaryGenreID: Int?

    enum CodingKeys: String, CodingKey {
        case wrapperType, artistType, artistName
        case artistLinkURL = "artistLinkUrl"
        case artistID = "artistId"
        case amgArtistID = "amgArtistId"
        case primaryGenreName
        case primaryGenreID = "primaryGenreId"
    }
}
