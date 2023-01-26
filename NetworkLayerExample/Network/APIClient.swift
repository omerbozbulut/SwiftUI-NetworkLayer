//
//  APIClient.swift
//  ApiClientWithAssociatedTypes
//
//  Created by Ömer Bozbulut on 25.01.2023.
//

import Foundation

public protocol APIClient {
    var baseUrlComponents: URLComponents { get }

    var decoder: JSONDecoder { get }

    var session: URLSession { get }

    func cancelAllTasks()
    
    func sendRequest<T: APIResource>(for resource: T, completion: @escaping (APIResult<T>) -> Void) -> URLSessionDataTask?
}

public extension APIClient {

    func cancelAllTasks() {
        session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
    }

    func sendRequest<T: APIResource>(for resource: T, completion: @escaping (APIResult<T>) -> Void) -> URLSessionDataTask? {
        /* Ağ bağlantısı kontrolü
        if let reachability = Reachability(), reachability.connection == .none {
            completion(.failure(error: APIError.unreachable))
            return nil
        }
        */
        
        guard
            let request = resource.buildRequest(withBaseUrl: baseUrlComponents.url),
            let url = request.url?.absoluteString
        else {
            completion(.failure(error: APIError.client))
            return nil
        }
        let task = session.dataTask(with: request) { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                let httpStatusCode = HTTPStatusCode(rawValue: httpResponse.statusCode)
                    
            else {
                completion(.failure(error: APIError.unrecognizedFormat))
                return
            }
            guard httpResponse.statusCode == 200 else {
                completion(.failure(error: APIError.network(httpStatusCode: httpStatusCode)))
                return
            }
            do {
                let resultData = try self.decoder.decode(T.Response.self, from: data!)
                completion(.success(result: resultData))
            } catch let error as NSError {
                completion(.failure(error: APIError.decoding(reason: error.userInfo)))
                return
            }
        }
        defer {
            NSLog("starting task with request URL \(url)")
            task.resume()
        }
        return task
    }
}
