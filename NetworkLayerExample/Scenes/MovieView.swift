//
//  MovieView.swift
//  ApiClientWithAssociatedTypes
//
//  Created by Ömer Bozbulut on 25.01.2023.
//

import SwiftUI

struct MovieView: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("**Name**: \(movie.title ?? "nil")")
            Text("**Vote**: \(movie.voteAverage)")
                }
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .padding()
                .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: Movie(adult: false, backdropPath: "backdropPath", genres: nil, id: 0, imdbID: nil, originalTitle: "original title", overview: nil, popularity: nil, posterPath: nil, releaseDate: nil, status: nil, title: "title", voteAverage: 0.0))
            .previewLayout(.sizeThatFits)
    }
}
