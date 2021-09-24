//
//  MovieListViewModel.swift
//  MovieDatabase
//
//  Created by Nilaakash Singh on 24/09/21.
//

import Foundation
import Combine
import ObjectMapper

class MovieListViewModel: ObservableObject {
    // MARK: - Variables
    @Published private(set) var movieArray = [Movie]()
    @Published private(set) var isLoading = false
    private let movieListService = MovieListService()
    
    // MARK: - API Method
    @MainActor
    func fetchMovieList() async throws {
        isLoading = true
        defer { isLoading = true }
        movieArray = try await movieListService.loadMovieList()
        if movieArray.count > 10 {
            movieArray.removeSubrange(10...)
        }
    }
}

private actor MovieListService {
    private var movieArray = [Movie]()
    private var url = NetworkLink.movieListUrlComponent.url
    
    func loadMovieList() async throws -> [Movie] {
        guard let url = self.url else { return [] }
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[Movie], Error>)  in
            WebService.request(url: url, type: MovieResponse.self) { result in
                switch result {
                case .success(let movieResponse):
                    guard let movieArray = movieResponse.movieArray else { return }
                    continuation.resume(returning: movieArray)
                    return
                case .failure(let error):
                    continuation.resume(throwing: error)
                    print(error)
                    return
                }
            }
        }
    }
}
