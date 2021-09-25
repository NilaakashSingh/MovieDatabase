//
//  Constants.swift
//  MovieDatabase
//
//  Created by Nilaakash Singh on 24/09/21.
//

import Foundation

struct NetworkLink {
    private static let accessToken = "Your Api Key"
    private static let apiHost = "api.themoviedb.org"
    private static let scheme = "https"
    private static let imageHost = "image.tmdb.org/t/p/w500"
    private static let genericPath = "/3/movie/"
    
    static func movieListUrlComponent() -> URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = apiHost
        components.path = "\(genericPath)popular"
        components.setQueryItems(with: ["api_key": "\(NetworkLink.accessToken)"])
        return components
    }
    
    static func imagePath(for string: String) -> String? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = imageHost
        components.path = "\(string)"
        return components.string?.removingPercentEncoding
    }
    
    static func movieDetailsUrlComponent(for movieID: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = apiHost
        components.path = "\(genericPath)\(movieID)"
        components.setQueryItems(with: ["api_key": "\(NetworkLink.accessToken)"])
        return components
    }
}
