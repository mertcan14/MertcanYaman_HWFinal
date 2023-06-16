//
//  MusicResult.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 6.06.2023.
//

import Foundation

public struct MusicResult: Decodable {
    let resultCount: Int?
    let results: [Music]?
}

public struct Music: Decodable {
    let artistID, collectionID: Int?
    let trackID: Int?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewURL, collectionViewURL: String?
    let trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let releaseDate: Date?
    let collectionExplicitness, trackExplicitness: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?
    let trackRentalPrice, collectionHDPrice, trackHDPrice, trackHDRentalPrice: Double?
    let contentAdvisoryRating, longDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable, trackRentalPrice
        case collectionHDPrice = "collectionHdPrice"
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case contentAdvisoryRating, longDescription
    }
    
    init(trackID: Int?, artistName: String?, trackName: String?, previewURL: String?, artworkUrl100: String?, primaryGenreName: String?) {
        self.artistID = nil
        self.collectionID = nil
        self.trackID = trackID
        self.artistName = artistName
        self.collectionName = nil
        self.trackName = trackName
        self.collectionCensoredName = nil
        self.trackCensoredName = nil
        self.artistViewURL = nil
        self.collectionViewURL = nil
        self.trackViewURL = nil
        self.previewURL = previewURL
        self.artworkUrl30 = nil
        self.artworkUrl60 = nil
        self.artworkUrl100 = artworkUrl100
        self.collectionPrice = nil
        self.trackPrice = nil
        self.releaseDate = nil
        self.collectionExplicitness = nil
        self.trackExplicitness = nil
        self.discCount = nil
        self.discNumber = nil
        self.trackCount = nil
        self.trackNumber = nil
        self.trackTimeMillis = nil
        self.country = nil
        self.currency = nil
        self.primaryGenreName = primaryGenreName
        self.isStreamable = nil
        self.trackRentalPrice = nil
        self.collectionHDPrice = nil
        self.trackHDPrice = nil
        self.trackHDRentalPrice = nil
        self.contentAdvisoryRating = nil
        self.longDescription = nil
    }
}
