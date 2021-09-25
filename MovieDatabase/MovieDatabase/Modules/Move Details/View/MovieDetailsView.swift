//
//  MovieDetailsView.swift
//  MovieDatabase
//
//  Created by Nilaakash Singh on 24/09/21.
//

import SwiftUI
import Kingfisher

struct MovieDetailsView: View {
    
    @ObservedObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                if viewModel.showLoadingIndicator {
                    LoadingView(loadingTitle: "Loading Movie Details...")
                } else {
                    KFImage(URL(string: viewModel.movieDetails?.posterURL() ?? .empty))
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, alignment: .center)
                    
                    VStack(alignment: .leading) {
                        contentBody
                        sourceBody
                    }
                    .padding([.leading, .trailing, .bottom])
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .onAppear {
            Task {
                try? await viewModel.fetchMovieDetails()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private var contentBody: some View {
        VStack(alignment: .leading) {
            Text(viewModel.movieDetails?.title ?? .empty)
                .font(.title2)
                .foregroundColor(.blue)
            
            if let tagline = viewModel.movieDetails?.tagline {
                Text(tagline)
                    .font(.subheadline)
                    .foregroundColor(.yellow)
            }
            
            Text(viewModel.movieDetails?.overview ?? .empty)
                .font(.body)
                .padding(.top)
                .foregroundColor(.gray)
        }
        .padding(.top)
    }
    
    private var sourceBody: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                genreView
                languageView
            }
            
            if let averageVote = viewModel.movieDetails?.voteAverage {
                Text("IMDB Rating: \(String(format: "%.1f", averageVote))")
                    .padding(.top, 20)
            }
            
            HStack(alignment: .top) {
                if let homepageLink = viewModel.movieDetails?.homepage,
                   homepageLink != .empty {
                    Text("Read More:")
                        .foregroundColor(.white)
                    Button(action: { openURL(urlString: homepageLink) },
                           label: { Text(homepageLink).multilineTextAlignment(.leading) })
                }
            }
            .padding(.top, 5)
        }
        .padding([.top, .bottom])
    }
}

// MARK: - Supporting Views
extension MovieDetailsView {
    private var genreView: some View {
        VStack {
            if let genreArray = viewModel.movieDetails?.genres {
                coloredTitle(title: "Genre")
                ForEach(genreArray, id: \.self) { genre in
                    coloredSubtitle(subtitle: genre.name ?? .empty)
                }
            }
        }
    }
    
    private var languageView: some View {
        VStack {
            if let languageAvailableArray = viewModel.movieDetails?.spokenLanguages {
                coloredTitle(title: "Available in")
                ForEach(languageAvailableArray, id: \.self) { languageAvailable in
                    coloredSubtitle(subtitle: languageAvailable.englishName ?? .empty)
                }
            }
        }
    }
    
    private func coloredTitle(title: String) -> some View {
        Text(title)
            .font(.title3)
    }
    
    private func coloredSubtitle(subtitle: String) -> some View {
        Text(subtitle)
            .font(.body)
            .padding()
            .frame(width: UIScreen.main.bounds.width / 2 - 30)
            .background(Color.random())
            .cornerRadius(5)
    }
}

// MARK: - Action Method
extension MovieDetailsView {
    private func openURL(urlString: String?) {
        if let url = URL(string: urlString ?? .empty) {
            UIApplication.shared.open(url)
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(viewModel: MovieDetailViewModel(movieID: "436969"))
    }
}
