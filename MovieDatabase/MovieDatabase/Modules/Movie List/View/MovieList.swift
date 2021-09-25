//
//  MovieList.swift
//  MovieDatabase
//
//  Created by Nilaakash Singh on 24/09/21.
//

import SwiftUI

struct MovieList: View {
    
    @StateObject private var viewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.showLoadingIndicator {
                    LoadingView(loadingTitle: "Loading Popular Movies ...")
                } else {
                    ForEach(viewModel.movieArray, id: \.self) { movie in
                        NavigationLink(
                            destination: MovieDetailsView(viewModel: MovieDetailViewModel(movieID: "\(movie.id ?? .zero)")),
                            label: {
                                MovieCell(imageUrl: movie.posterURL(),
                                          title: movie.title,
                                          averageRating: movie.voteAverage)
                            })
                    }
                }
            }
            .onFirstAppear {
                Task {
                    try? await viewModel.fetchMovieList()
                }
            }
            .navigationTitle("Popular Movies")
        }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}
