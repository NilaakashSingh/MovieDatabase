//
//  MovieDetails.swift
//  MovieDatabase
//
//  Created by Nilaakash Singh on 25/09/21.
//

import ObjectMapper

// MARK: - Movie Details
struct MovieDetails: Mappable {
    var adult: Bool?
    var genres: [Genre]?
    var homepage: String?
    var id: Int?
    var originalTitle: String?
    var overview: String?
    var posterPath: String?
    var releaseDate: String?
    var spokenLanguages: [SpokenLanguage]?
    var tagline: String?
    var title: String?
    var voteAverage: Double?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        adult <- map["adult"]
        genres <- map["genres"]
        homepage <- map["homepage"]
        id <- map["id"]
        originalTitle <- map["original_title"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        releaseDate <- map["release_date"]
        spokenLanguages <- map["spoken_languages"]
        tagline <- map["tagline"]
        title <- map["title"]
        voteAverage <- map["vote_average"]
    }
    
    func posterURL() -> String? {
        return NetworkLink.imagePath(for: posterPath ?? .empty)
    }
}

// MARK: - Genre
struct Genre: Mappable {
    var id: Int?
    var name: String?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    var englishName: String?

    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        englishName <- map["english_name"]
    }
}
