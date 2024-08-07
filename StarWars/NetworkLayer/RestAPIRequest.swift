//
//  RestAPIRequest.swift
//  StarWars
//
//  Created by Arun on 07/08/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol RestAPIRequest {
    
    var baseUrl: String { get }
    
    var path: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var queryItems: [URLQueryItem]? { get }
    
    var body: Encodable? { get }
    
    var headers: [String: String]? { get }
}

extension RestAPIRequest {
    
    var baseUrl: String {
        "https://4f1c8b6e-4522-4ee9-bc7f-f1c551fa1f36.mock.pstmn.io"
    }
    
    var queryItems: [URLQueryItem]? {
        nil
    }
    
    var headers: [String: String]? {
        nil
    }
    
    var body: Encodable? {
        nil
    }
}
