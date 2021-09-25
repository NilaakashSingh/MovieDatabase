//
//  Movies.swift
//  MovieDatabase
//
//  Created by Nilaakash Singh on 24/09/21.
//

import ObjectMapper
import Foundation

// MARK: - MovieResponse
struct MovieResponse: Mappable, Hashable {
    
    var movieArray: [Movie]?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        movieArray <- map["results"]
    }
}

// MARK: - Result
struct Movie: Mappable, Hashable {
    var genreIDS: [Int]?
    var id: Int?
    var popularity: Double?
    var posterPath, title: String?
    var voteAverage: Double?
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        genreIDS <- map["genreIDS"]
        id <- map["id"]
        popularity <- map["popularity"]
        posterPath <- map["poster_path"]
        title <- map["title"]
        voteAverage <- map["vote_average"]
    }
    
    func posterURL() -> String? {
        return NetworkLink.imagePath(for: posterPath ?? .empty)
    }
}
