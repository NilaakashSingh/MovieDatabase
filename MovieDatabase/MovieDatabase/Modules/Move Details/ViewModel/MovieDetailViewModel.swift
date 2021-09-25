//
//  MovieDetailViewModel.swift
//  MovieDatabase
//
//  Created by Nilaakash Singh on 24/09/21.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published private(set) var movieDetails: MovieDetails?
    @Published private(set) var showLoadingIndicator = false
    private let movieListDetailService: MovieListDetailService?
    
    init(movieID: String) {
        movieListDetailService = MovieListDetailService(movieID: movieID)
    }
    
    // MARK: - API Method
    @MainActor
    func fetchMovieDetails() async throws {
        showLoadingIndicator = true
        defer { showLoadingIndicator = false }
        movieDetails = try? await movieListDetailService?.loadMovieDetails()
    }
}

private actor MovieListDetailService {
    private var url: URL?
    
    init(movieID: String) {
        url = NetworkLink.movieDetailsUrlComponent(for: movieID).url
    }
    
    func loadMovieDetails() async throws -> MovieDetails? {
        guard let url = self.url else { return nil }
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<MovieDetails, Error>)  in
            WebService.request(url: url, type: MovieDetails.self) { result in
                switch result {
                case .success(let movieResponse):
                    continuation.resume(returning: movieResponse)
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
