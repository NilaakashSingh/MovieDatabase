//
//  URLComponents+Extensions.swift
//  MovieDatabase
//
//  Created by Nilaakash Singh on 24/09/21.
//

import Foundation

extension URLComponents {
    /// Maps a dictionary into `[URLQueryItem]` then assigns it to the
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
