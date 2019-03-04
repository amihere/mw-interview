//
//  NetworkInteraction.swift
//  MeltwaterLabsInterview
//
//  Created by Ayeba Amihere on 02/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import Foundation

enum HTTPMethod:String{
    case GET = "GET"
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol GetData: AnyObject {
    static func get<K: Codable>(url: URL, completion: @escaping (Result<K>) -> Void)
}

internal class NetworkInteraction: GetData{
    private static func getSessionConfig() -> URLSessionConfiguration{
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20.0
        sessionConfig.timeoutIntervalForResource = 30.0
        
        return sessionConfig
    }
    
    // Gets resources from a specified URL
    static func get<K: Codable>(url: URL, completion: @escaping (Result<K>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue

        let session = URLSession(configuration: getSessionConfig())
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                completion(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let objects = try decoder.decode(K.self, from: jsonData)
                    let result: Result<K> = Result.success(objects)
                    completion(result)
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
