//
//  NetworkService.swift
//  SocialNetworkFeed
//
//  Created by admin on 3/7/2025.
//

import UIKit
//https://jsonplaceholder.typicode.com/comments
// users
// posts
final class NetworkService {
    
    static let shared = NetworkService(); private init() {}
    let session = URLSession.shared
    
    func fetchData<T: Decodable>(endpoint: URLManager.EndPoint, completion: @escaping (Result<T, Error>) -> Void) {
            guard let url = URLManager.shared.createURL(withEndPoint: endpoint) else {
                completion(.failure(HTTPError.invalidURL))
                return
            }
            
            session.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(HTTPError.invalidData))
                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    
}
