//
//  HTTPMethod.swift
//  ApiClientWithAssociatedTypes
//
//  Created by Ömer Bozbulut on 25.01.2023.
//

import Foundation

public enum HTTPRequestMethod: String {
    case GET = "get", POST = "post"
}

public enum HTTPStatusCode: Int {
    case informational
    case success
    case redirection
    case clientError
    case serverError

    public init?(rawValue: Int) {
        switch rawValue {
        case 100...199: self = .informational
        case 200...299: self = .success
        case 300...399: self = .redirection
        case 400...499: self = .clientError
        case 500...599: self = .serverError
        default: return nil
        }
    }

    var ok: Bool {
        rawValue == 200
    }
}
