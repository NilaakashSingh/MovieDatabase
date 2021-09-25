//
//  LoadingView.swift
//  MovieDatabase
//
//  Created by Nilaakash Singh on 25/09/21.
//

import SwiftUI

struct LoadingView: View {
    let loadingTitle: String
    
    var body: some View {
        ProgressView(loadingTitle)
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .foregroundColor(.blue)
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(loadingTitle: "Loading...")
    }
}
