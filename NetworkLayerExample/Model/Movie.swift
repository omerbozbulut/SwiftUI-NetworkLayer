//
//  News.swift
//  ApiClientWithAssociatedTypes
//
//  Created by Ömer Bozbulut on 25.01.2023.
//

import Foundation

struct MovieData: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let genres: [Genre]?
    let id: Int
    let imdbID: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let status, title: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genres, id
        case imdbID = "imdb_id"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case status, title
        case voteAverage = "vote_average"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
