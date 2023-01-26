//
//  APIResource.swift
//  ApiClientWithAssociatedTypes
//
//  Created by Ömer Bozbulut on 25.01.2023.
//

import Foundation

public protocol APIResource {
    
    // Response çözülürken kullanılacak ilişki türü
    associatedtype Response: Codable
    
    var additionalHeaders: [String: String]? { get }
    
    var httpBody: Data? { get }
    
    var httpRequestMethod: HTTPRequestMethod { get }
    
    var path: String { get }
    
    var queryItems: [URLQueryItem]? { get }
}

extension APIResource {
    func buildRequest(withBaseUrl baseUrl: URL?) -> URLRequest? {
        guard let url = buildUrl(withBaseUrl: baseUrl) else {
            NSLog("failed to build request for resource: \(String(describing: self))")
                        return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpRequestMethod.rawValue
        request.httpBody = httpBody
        
        additionalHeaders?.forEach({ (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        })
        
        return request
    }
    
    func buildUrl(withBaseUrl BaseUrl: URL?) -> URL? {
        guard let baseUrl = BaseUrl,
              var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        else {
            NSLog("failed to build url for resource: \(String(describing: self))")
            return nil
        }
        components.path = baseUrl.path.appending(path)
        components.queryItems = queryItems
        return components.url
    }
}

public enum APIError: Error {
    case client

    case decoding(reason: [String: Any]?)

    case network(httpStatusCode: HTTPStatusCode)

    case unrecognizedFormat

    case unreachable
}

public enum APIResult<T: APIResource> {
    case failure(error: APIError)
    case success(result: T.Response)
}
