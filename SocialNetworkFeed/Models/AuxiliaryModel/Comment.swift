//
//  Comment.swift
//  SocialNetworkFeed
//
//  Created by admin on 3/7/2025.
//

import Foundation

struct Comment: Identifiable, Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
