//
//  Posts.swift
//  SocialNetworkFeed
//
//  Created by admin on 3/7/2025.
//

import Foundation

struct Post: Identifiable, Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
