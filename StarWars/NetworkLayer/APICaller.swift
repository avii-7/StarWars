//
//  APICaller.swift
//  StarWars
//
//  Created by Arun on 12/07/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

final class APICaller {
    
    private init() { }
    
    static let shared = APICaller()
    
    func get<T: Decodable>(_ request: URLRequest) async throws -> T? {
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        }
        
        return nil
    }
}
