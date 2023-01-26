//
//  ContentView.swift
//  ApiClientWithAssociatedTypes
//
//  Created by Ömer Bozbulut on 25.01.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View {
        VStack {
            Text("Movies")
                .bold()
                .fontWeight(.semibold)
            List(viewModel.movies, id: \.id) { movie in
                MovieView(movie: movie)
            }
            .cornerRadius(9)
            .onAppear {
                viewModel.fetchMovie()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
