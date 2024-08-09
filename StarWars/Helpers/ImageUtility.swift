//
//  ImageUtility.swift
//  StarWars
//
//  Created by Arun on 08/08/24.
//

import Foundation
import UIKit

struct PhotoModel: Codable {
    let a: Int
}

struct ImageUtility {
    
    private init() { }
    
    static let shared = ImageUtility()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func setImageAsync(urlString: String, completionHandler: @escaping ((UIImage?) -> Void)) {
        
        let key = NSString(string: urlString)
        
        if let value = cache.object(forKey: key) {
            completionHandler(value)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completionHandler(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let data, error == nil {
                let image = UIImage(data: data)
                if let image {
                    cache.setObject(image, forKey: NSString(string: url.absoluteString))
                }
                completionHandler(image)
                return
            }
            completionHandler(nil)
        }
        task.resume()
    }
}
