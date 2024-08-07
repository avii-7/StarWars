//
//  HttpUtility.swift
//  StarWars
//
//  Created by Arun on 12/07/24.
//

import Foundation


final class HttpUtility {
    
    private init() { }
    
    static let shared = HttpUtility()
    
    func hit<T: Decodable>(_ request: RestAPIRequest) async throws -> T? {
        
        guard let request = try prepareURLRequest(from: request) else { return nil }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if
            let httpResponse = response as? HTTPURLResponse,
            200...299 ~= httpResponse.statusCode {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        }
        
        return nil
    }
    
    private func prepareURLRequest(from request: RestAPIRequest) throws -> URLRequest? {
        let stringBaseUrl = request.baseUrl
        
        guard var url = URL(string: stringBaseUrl) else { return nil }
        url.append(path: request.path, directoryHint: .notDirectory)
        
        if let queryItems = request.queryItems {
            url.append(queryItems: queryItems)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        if let body = request.body {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        }
        
        debugPrint(urlRequest.url ?? "")
        
        return urlRequest
    }
}
