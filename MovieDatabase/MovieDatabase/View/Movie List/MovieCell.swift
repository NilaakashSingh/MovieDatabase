//
//  MovieCell.swift
//  MovieDatabase
//
//  Created by Nilaakash Singh on 24/09/21.
//

import SwiftUI
import Kingfisher

struct MovieCell: View {
    
    // MARK: - Variables
    let imageUrl: String?
    let title: String?
    let averageRating: Double?
    
    private struct LayoutConstants {
        static let imageWidth: CGFloat = 100
        static let imageHeight: CGFloat = 200
        static let topPadding: CGFloat = 30
    }
    
    // MARK: - Movie Cell Body
    var body: some View {
        HStack(alignment: .top) {
            if let url = URL(string: imageUrl ?? .empty)  {
                KFImage(url)
                    .resizable()
                    .scaledToFit()
                    .frame(width: LayoutConstants.imageWidth,
                           height: LayoutConstants.imageHeight,
                           alignment: .center)
            }
            
            VStack(alignment: .leading) {
                Text(title ?? .empty)
                    .font(.largeTitle)
                
                Text("Average Rating: \(String(format: "%.1f", averageRating ?? .zero))")
                    .font(.title2)
                    .foregroundColor(Color.yellow)
            }
            .padding([.top, .bottom], LayoutConstants.topPadding)
            .padding(.leading)
        }
        .padding([.leading, .trailing])
    }
}

// MARK: - Preview
struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell(imageUrl: NetworkLink.imagePath(for: "/8Ls1tZ6qjGzfGHjBB7ihOnf7f0b.jpg"), title: "Stillwater", averageRating: 7.1)
    }
}
