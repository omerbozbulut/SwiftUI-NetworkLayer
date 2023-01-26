//
//  NewsService.swift
//  ApiClientWithAssociatedTypes
//
//  Created by Ömer Bozbulut on 25.01.2023.
//

import Foundation

struct GetMovies: APIResource {
    typealias Response = MovieData
    
    var additionalHeaders: [String : String]?
    
    var httpBody: Data?
    
    var httpRequestMethod: HTTPRequestMethod = .GET
    
    var path: String {
        return NetworkConstants.BASE_URL
    }
    
    var queryItems: [URLQueryItem]? = [URLQueryItem(name: "api_key", value: NetworkConstants.urlQueryItems.api_key.rawValue)]
}

class MovieAPIClient: APIClient {
    
    static let shared = MovieAPIClient()
    
    var baseUrlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        return components
    }()
    
    var decoder: JSONDecoder = JSONDecoder()
    
    var session: URLSession = URLSession.shared
}
