//
//  User.swift
//  SocialNetworkFeed
//
//  Created by admin on 3/7/2025.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: Int
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    /// Кастомное свойство для получения аватарки пользователя
    var avatar: String {
        return "https://robohash.org/\(id)?set=set4"
    }
    
}
