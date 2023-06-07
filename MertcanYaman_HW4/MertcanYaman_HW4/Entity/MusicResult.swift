//
//  MusicResult.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 6.06.2023.
//

import Foundation

struct MusicResult: Decodable {
    let resultCount: Int?
    let results: [Music]?
}

struct Music: Decodable {
    let wrapperType: String?
    let kind: String?
    let artistID: Int?
    let collectionID, trackID: Int?
    let artistName, collectionName, trackName, collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewURL: String?
    let collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let releaseDate: Date?
    let collectionExplicitness, trackExplicitness: String?
    let discCount, discNumber: Int?
    let trackCount: Int?
    let trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?
    let feedURL: String?
    let collectionHDPrice: Int?
    let contentAdvisoryRating: String?
    let artworkUrl600: String?
    let genreIDS, genres: [String]?
    let collectionArtistID: Int?
    let collectionArtistName: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable
        case feedURL = "feedUrl"
        case collectionHDPrice = "collectionHdPrice"
        case contentAdvisoryRating, artworkUrl600
        case genreIDS = "genreIds"
        case genres
        case collectionArtistID = "collectionArtistId"
        case collectionArtistName
    }
}

//enum Explicitness: String, Decodable {
//    case cleaned = "cleaned"
//    case explicit = "explicit"
//    case notExplicit = "notExplicit"
//}
//
//enum Kind: String, Decodable {
//    case book = "book"
//    case album = "album"
//    case coachedAudio = "coached-audio"
//    case featureMovie = "feature-movie"
//    case interactiveBooklet = "interactive-booklet"
//    case musicVideo = "music-video"
//    case pdfPodcast = "pdf podcast"
//    case podcastEpisode = "podcast-episode"
//    case softwarePackage = "software-package"
//    case song = "song"
//    case tvEpisode = "tv-episode"
//    case artist = "artist"
//
//}
//
//enum WrapperType: String, Decodable {
//    case track = "track"
//    case collection = "collection"
//    case artist = "artist"
//}
