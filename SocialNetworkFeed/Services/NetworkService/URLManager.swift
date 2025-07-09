//
//  URLManager.swift
//  SocialNetworkFeed
//
//  Created by admin on 3/7/2025.
//

import Foundation

final class URLManager {
    static let shared = URLManager(); private init() {}
    
    let getaway = "https://"
    let server = "jsonplaceholder.typicode.com/"
    
    func createURL(withEndPoint endPoint: EndPoint) -> URL? {
        guard let url = URL(string: "\(getaway)\(server)\(endPoint.rawValue)") else { return nil }
        return url
    }
    
    enum EndPoint: String {
        case comments = "comments"
        case users = "users"
        case posts = "posts"
    }
}


