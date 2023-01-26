//
//  MoviesViewModel.swift
//  ApiClientWithAssociatedTypes
//
//  Created by Ömer Bozbulut on 25.01.2023.
//

import Foundation

@MainActor class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    
    func fetchMovie() {
        let resource = GetMovies()
        _ = MovieAPIClient.shared.sendRequest(for: resource) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movieData):
                DispatchQueue.main.async {
                    self.movies = movieData.results
                }
            }
        }
    }
}

