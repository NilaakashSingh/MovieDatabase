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
            List {
                ForEach(viewModel.movieArray, id: \.self) { movie in
                    NavigationLink(
                        destination: MovieDetailsView(),
                        label: {
                            MovieCell(imageUrl: movie.posterURL(),
                                      title: movie.title,
                                      averageRating: movie.voteAverage)
                        })
                }
            }
            .listStyle(PlainListStyle())
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
