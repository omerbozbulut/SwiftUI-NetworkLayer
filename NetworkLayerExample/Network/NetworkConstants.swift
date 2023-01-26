//
//  NetworkConstants.swift
//  ApiClientWithAssociatedTypes
//
//  Created by Ömer Bozbulut on 26.01.2023.
//

import Foundation

struct NetworkConstants {
    static let BASE_URL = "api.themoviedb.org/3/movie/upcoming"
    
    
    enum urlQueryItems: String {
        case api_key = "f7e4d60f9116a60ca46ab131ae2d83ad"
    }
}
